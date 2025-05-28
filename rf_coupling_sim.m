%% RF Data Transmission via Low Frequency Coupling Capacitance
% Project Title: Optimized RF Communication using Coupling Capacitance
% Author: Aatman Patel
% Description: Simulates BPSK transmission over a capacitive-coupled noisy channel

%% PARAMETERS
numBits = 10000;        % Number of bits
bitrate = 7400;         % Bitrate in bps
Fs = 10e6;              % Sampling frequency (10 MHz)
Fc = 180e3;             % Carrier frequency (180 kHz)
SNR_dB = -12;           % Signal-to-noise ratio
rolloff = 0.35;

%% Generate Random Bitstream
bits = randi([0 1], 1, numBits);

%% BPSK Modulation
bpskSignal = 2*bits - 1; % Map 0 -> -1, 1 -> +1

%% Pulse Shaping (Raised Cosine Filter)
sps = floor(Fs / bitrate); % Samples per symbol
filt = rcosdesign(rolloff, 6, sps, 'normal');
txShaped = upfirdn(bpskSignal, filt, sps);

%% Carrier Modulation
t = (0:length(txShaped)-1) / Fs;
carrier = cos(2*pi*Fc*t);
txModulated = txShaped .* carrier;

%% Simulate Capacitive Coupling Channel
% Basic model: apply high-pass filter to simulate capacitive loss
[b_hp, a_hp] = butter(1, 50/Fs, 'high');
txChannel = filter(b_hp, a_hp, txModulated);

%% Additive White Gaussian Noise
rxNoisy = awgn(txChannel, SNR_dB, 'measured');

%% Demodulation
rxDemod = rxNoisy .* carrier; % Multiply with carrier again (coherent demod)
[b_lp, a_lp] = butter(6, 5e3/Fs); % LPF to retrieve baseband
rxFiltered = filter(b_lp, a_lp, rxDemod);

%% Matched Filter and Downsampling
rxMatched = conv(rxFiltered, filt, 'same');
rxDownsampled = downsample(rxMatched, sps);

%% Bit Decision
rxBits = rxDownsampled > 0;

%% BER Calculation
BER = sum(bits ~= rxBits) / numBits;
fprintf('Bit Error Rate: %.5f\n', BER);

%% Plot Spectrums
figure;
subplot(2,1,1);
pwelch(txModulated,[],[],[],Fs,'centered');
title('Transmitted Spectrum');
subplot(2,1,2);
pwelch(rxNoisy,[],[],[],Fs,'centered');
title('Received Spectrum (After Channel + Noise)');
