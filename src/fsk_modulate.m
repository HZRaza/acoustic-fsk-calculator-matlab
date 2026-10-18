function frame = fsk_modulate(bits, p)
%FSK_MODULATE  Bits -> audio frame: [chirp preamble][FSK symbols].
    bits = bits(:);
    t = (0:p.N-1)' / p.fs;
    tone0 = sin(2*pi*p.f0*t);
    tone1 = sin(2*pi*p.f1*t);
    sym = zeros(p.N, numel(bits));
    sym(:, bits == 0) = repmat(tone0, 1, nnz(bits == 0));
    sym(:, bits == 1) = repmat(tone1, 1, nnz(bits == 1));
    frame = [p.preamble; sym(:)];
    frame = frame / max(abs(frame)) * 0.8;   % normalise, leave headroom
end
