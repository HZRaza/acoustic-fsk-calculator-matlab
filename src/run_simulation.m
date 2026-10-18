%RUN_SIMULATION  Full two-computer calculator round trip, on one machine.
%   A: "12+34" --FSK--> B: decode, sum, --FSK--> A: displays "46"
clear; clc; close all; rng(1);
p = fsk_params();
snr_db = -10;                      % try -20 to 10 and watch it break
msg = '12+34';

% ---- Computer A -> channel -> Computer B ----
frameA = fsk_modulate(text_to_bits(msg), p);
rxB    = channel_sim(frameA, snr_db, 0.3, p);
gotB   = receive_message(rxB, p);
fprintf('B received : "%s"\n', gotB);

% ---- Computer B computes and replies ----
reply  = compute_sum(gotB);
frameB = fsk_modulate(text_to_bits(reply), p);
rxA    = channel_sim(frameB, snr_db, 0.5, p);
gotA   = receive_message(rxA, p);
fprintf('A displays : %s = %s\n', msg, gotA);

% ---- Plots ----
if ~exist('../results','dir'), mkdir('../results'); end
tB = (0:numel(rxB)-1)'/p.fs;
fig = figure('Position',[100 100 900 600]);
subplot(2,1,1); plot((0:numel(frameA)-1)/p.fs, frameA);
title('Transmitted frame (chirp preamble + FSK data)'); xlabel('Time (s)'); ylabel('Amplitude'); grid on;
subplot(2,1,2); plot(tB, rxB);
title(sprintf('Received at B (SNR = %d dB, random delay)', snr_db)); xlabel('Time (s)'); ylabel('Amplitude'); grid on;
saveas(fig, '../results/waveforms.png');

if exist('spectrogram','file')
    fig2 = figure;
    spectrogram(frameA, 512, 384, 1024, p.fs, 'yaxis'); ylim([0 5]);
    title('Spectrogram of transmitted frame');
    saveas(fig2, '../results/spectrogram.png');
end
