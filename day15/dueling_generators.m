function dueling_generators( initGen )
    tic
    gen = uint64(initGen);
    FACT = uint64([16807 48271]);
    PAIRS = 40000000;
    cnt = 0;
    MASK = hex2dec('ffff');
    
    for i = 1:PAIRS
        gen = mod(gen .* FACT, 2147483647);
        lowbits = bitand(gen, MASK);
        if lowbits(1) == lowbits(2)
            cnt = cnt + 1;
        end
        % fprintf('%10d %10d\n', gen(1), gen(2));
    end
    fprintf('result1: %d\n', cnt);
    toc
end

