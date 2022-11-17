state(idle, null, null, null).
state(configuration, 'Configuration mode', null, null).
state(reading, 'Sequence of beeps', 'Switch off LEDs', blink-led).
state(emergency, 'Fire siren', 'Exit emergency', send-notification).
state(final, null, null, null).

initial(idle).

final(exit).

transition(idle, configuration, configure, 'coThresh == null, tempThresh == null', null).
transition(idle, reading, read, 'coThresh != null, tempThresh != null', null).
transition(idle, exit, 'shut off', null, null).
transition(configuration, reading, configure, 'coThresh <= 120 && coThresh >= 100, tempThresh > currentTemp', null).
transition(reading, configuration, configure, null, 'switch off LEDs').
transition(reading, emergency, null, 'currentTemp >= tempThresh, currentCo >= coThresh', 'switch off LEDs').
transition(reading, idle, null, 'elapsedTime >= 15s', 'switch off LEDs').
transition(emergency, reading, reset, null, null).

