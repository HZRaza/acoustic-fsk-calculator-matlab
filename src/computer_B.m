%COMPUTER_B  Listens, decodes, computes the sum, and transmits the answer.
%   Run this first, wait for "listening", then run computer_A on the other laptop.
clear; clc;
p = fsk_params();
rec = audiorecorder(p.fs, 16, 1);

fprintf('B listening (8 s)...\n');
recordblocking(rec, 8);
rx = getaudiodata(rec);

txt = receive_message(rx, p);
fprintf('B heard: "%s"\n', txt);
reply = compute_sum(txt);
fprintf('B computed: %s\n', reply);

frame = fsk_modulate(text_to_bits(reply), p);
pause(0.5);
playblocking(audioplayer(frame, p.fs));
fprintf('B replied.\n');
