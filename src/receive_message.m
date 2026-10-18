function txt = receive_message(rx, p)
%RECEIVE_MESSAGE  Full receiver: sync -> demodulate -> bits -> text.
    start = find_frame_start(rx, p);
    bits  = fsk_demodulate_bits(rx(start:end), p);
    txt   = bits_to_text(bits);
end
