function start = find_frame_start(rx, p)
%FIND_FRAME_START  Locate first data sample by matched-filtering the preamble.
    rx = rx(:);
    c = conv(rx, flipud(p.preamble));        % matched filter
    [~, idx] = max(abs(c));
    start = idx + 1;                         % data begins right after chirp
end
