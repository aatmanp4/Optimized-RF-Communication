# Optimized RF Data Transmission via Coupling Capacitance

This project simulates a complete baseband-to-passband transmission of BPSK-modulated data over a capacitive-coupled channel with additive noise.

### Features
- BPSK Modulation and Demodulation
- Raised Cosine Pulse Shaping
- High-pass filtering to simulate capacitive channel loss
- Carrier modulation at 180 kHz
- Additive White Gaussian Noise (AWGN)
- Spectral analysis and BER calculation

### Tools & Technologies
- MATLAB
- DSP Toolbox
- Signal processing and RF simulation

### Run Instructions
Simply run `rf_coupling_sim.m` in MATLAB. It will:
1. Generate a random bitstream
2. Modulate using BPSK
3. Transmit through a simulated capacitive channel
4. Add noise, demodulate, filter, and recover the signal
5. Output BER and spectrum plots

### Output Example
- Bit Error Rate (BER)
- Transmitted and received spectra

### Author
**Aatman Patel**
