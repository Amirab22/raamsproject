function data = extractDataRamsey(result_struct)
% extractDataRamsey(result_struct) takes an experiment result struct for
% Ramsey experimend.
%
% returns a struct which includes fields of time, signal, sterr

data = struct;
s = struct;
err = struct;

if isfield(result_struct,'Ramsey')
    rawDataStruct = result_struct.Ramsey;
    data.time = rawDataStruct.tau;
elseif isfield(result_struct,'RamseyWithLaser')
    rawDataStruct = result_struct.RamseyWithLaser;
    data.time = rawDataStruct.tau;
elseif isfield(result_struct,'ExpRaamS3')
    rawDataStruct = result_struct.ExpRaamS3;
    data.time = rawDataStruct.smallPiTime;
elseif isfield(result_struct,'ExpRaamS3WithLaser')
    rawDataStruct = result_struct.ExpRaamS3WithLaser;
    data.time = rawDataStruct.smallPiTime;
end

repeats = rawDataStruct.repeats;
iter = rawDataStruct.currIter -1;

zero_sig_raw = squeeze(rawDataStruct.signal(1,:,1:iter));
zero_ref_raw = squeeze(rawDataStruct.signal(2,:,1:iter));

one_sig_raw = squeeze(rawDataStruct.signal(3,:,1:iter));
one_ref_raw = squeeze(rawDataStruct.signal(4,:,1:iter));

zero_sig_mean = mean(zero_sig_raw,2);
zero_ref_mean = mean(zero_ref_raw,2);

one_sig_mean = mean(one_sig_raw,2);
one_ref_mean = mean(one_ref_raw,2);

zero_sig_sterr = getCombinedSterr(zero_sig_raw,squeeze(rawDataStruct.sterr(1,:,1:iter)));
zero_ref_sterr = getCombinedSterr(zero_ref_raw,squeeze(rawDataStruct.sterr(2,:,1:iter)));

one_sig_sterr = getCombinedSterr(one_sig_raw,squeeze(rawDataStruct.sterr(3,:,1:iter)));
one_ref_sterr = getCombinedSterr(one_ref_raw,squeeze(rawDataStruct.sterr(4,:,1:iter)));

zero_sterr = (zero_sig_mean./zero_ref_mean).*sqrt(zero_sig_sterr.^2./zero_sig_mean.^2 + zero_ref_sterr.^2./zero_ref_mean.^2);
one_sterr = (one_sig_mean./one_ref_mean).*sqrt(one_sig_sterr.^2./one_sig_mean.^2 + one_ref_sterr.^2./one_ref_mean.^2);


one_norm = zero_sig_mean./zero_ref_mean;
zero_norm = one_sig_mean./one_ref_mean;
fl_referenced = -one_norm + zero_norm;


%     sterr = [one_sterr,zero_sterr,sqrt(one_sterr.^2 + zero_sterr.^2)];
%     signal = [one_norm,zero_norm,fl_referenced];
%     domain = result_struct.Ramsey.tau;

err.one_err = one_sterr;
err.zero_err = zero_sterr;
err.ref_err = sqrt(one_sterr.^2 + zero_sterr.^2);
s.one = one_norm;
s.zero = zero_norm;
s.referenced = fl_referenced;
data.sterr = err;
data.signal = s;
    function sterr = getCombinedSterr( means, sterrs)
        % Calculate the combined standard error when combining the data
        % coming from several normal distribution. Formula taken from:
        % https://math.stackexchange.com/questions/2971315/how-do-i-combine-standard-deviations-of-two-groups
        % Note that it was adjusted for standard error (and not
        % deviation), and runs iteratively.
        m = repeats;
        meanSoFar = means(:,1);
        sterrSoFar = sterrs(:,1);
        for i = 2:size(means, 2)
            n = m * (i-1);
            meanSoFar = ((i-2)*meanSoFar+means(:,i-1))/(i-1);
            sterrSoFar = sqrt(((n*(n-1)*sterrSoFar.^2)+(m*(m-1)*sterrs(:,i).^2))./((n+m)*(n+m-1)) + n*m*(meanSoFar-means(:,i)).^2 ./ ((n+m)^2*(n+m-1)));
        end
        sterr = sterrSoFar;
    end

end