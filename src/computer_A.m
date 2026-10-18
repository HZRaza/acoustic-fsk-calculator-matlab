%COMPUTER_A  Sends the calculation, then listens for the answer.
%   Start computer_B FIRST, wait for it to say "listening", then run this.
clear; clc;
p = fsk_params();
msg = input('Enter calculation (e.g. 12+34): ', 's');

frame = fsk_modulate(text_to_bits(msg), p);
player = audioplayer(frame, p.fs);
rec = audiorecorder(p.fs, 16, 1);

fprintf('Sending "%s"...\n', msg);
playblocking(player);

fprintf('Listening for reply (14 s)...\n');
recordblocking(rec, 14);
rx = getaudiodata(rec);

reply = receive_message(rx, p);
fprintf('\nResult: %s = %s\n', msg, reply);
