function bits = fsk_demodulate_bits(rx, p)
%FSK_DEMODULATE_BITS  Non-coherent FSK detector on a symbol-aligned signal.
%   For each symbol, compare the energy at f0 vs f1 (correlation with
%   complex exponentials, so unknown phase does not matter).
    rx = rx(:);
    nsym = floor(numel(rx) / p.N);
    if nsym < 1,  bits = zeros(0,1);  return;  end
    seg = reshape(rx(1:nsym*p.N), p.N, nsym);
    t = (0:p.N-1)' / p.fs;
    e0 = abs(sum(seg .* exp(-2j*pi*p.f0*t), 1));
    e1 = abs(sum(seg .* exp(-2j*pi*p.f1*t), 1));
    bits = double(e1 > e0)';
end
