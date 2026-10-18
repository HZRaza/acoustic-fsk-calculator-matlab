%BER_VS_SNR  Bit error rate of the FSK link as noise increases.
clear; clc; close all; rng(2);
p = fsk_params();
snr_list = -26:2:0;                % wideband SNR in dB
nbits = 4000;
ber = zeros(size(snr_list));
for k = 1:numel(snr_list)
    bits = randi([0 1], nbits, 1);
    frame = fsk_modulate(bits, p);
    rx = channel_sim(frame, snr_list(k), 0, p);
    data = rx(numel(p.preamble)+1 : numel(p.preamble)+nbits*p.N);  % aligned
    est = fsk_demodulate_bits(data, p);
    ber(k) = mean(est ~= bits);
    fprintf('SNR %4d dB  BER %.4f\n', snr_list(k), ber(k));
end
ber_plot = max(ber, 1/(2*nbits));  % floor so zero errors show on log axis
if ~exist('../results','dir'), mkdir('../results'); end
fig = figure;
semilogy(snr_list, ber_plot, 'o-', 'LineWidth', 1.5); grid on;
xlabel('Wideband SNR (dB)'); ylabel('Bit error rate');
title(sprintf('Non-coherent FSK, %d baud, %d/%d Hz', p.baud, p.f0, p.f1));
saveas(fig, '../results/ber_vs_snr.png');
