function rx = channel_sim(frame, snr_db, lead_s, p)
%CHANNEL_SIM  Simple channel: random delay + additive white Gaussian noise.
%   snr_db is the wideband SNR over the whole audio bandwidth (fs/2).
    lead = round(lead_s * p.fs);
    tail = round(0.2 * p.fs);
    sigPow = mean(frame.^2);
    sigma  = sqrt(sigPow / 10^(snr_db/10));
    rx = [zeros(lead,1); frame(:); zeros(tail,1)];
    rx = rx + sigma * randn(size(rx));
end
