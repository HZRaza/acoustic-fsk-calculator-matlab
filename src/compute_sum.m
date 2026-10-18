function reply = compute_sum(txt)
%COMPUTE_SUM  Computer B's job: parse "a+b+c" and return the sum as text.
%   Returns 'ERR' if the received text is empty, corrupted, or not a sum.
    if isempty(txt) || ~all(ismember(txt, '0123456789+-. '))
        reply = 'ERR';
        return;
    end
    nums = str2double(strsplit(strtrim(txt), '+'));
    if isempty(nums) || any(isnan(nums))
        reply = 'ERR';
    else
        reply = num2str(sum(nums));
    end
end
