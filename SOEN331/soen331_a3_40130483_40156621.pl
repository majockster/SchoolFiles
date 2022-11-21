%Etienne Pham Do 40130483
%Hamzah Muhammad 40156621


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





get_legal_events_by_mode(S, EventList) :-
    findall(E,
            (transition(S,_,E,_,_),
                E \= 'null'),
            EventList).


get_system_actions(ActionList) :-
    findall(Action,
            (transition(_,_,_,_,Action), 
            (Action \= 'null')),
            ActionList).

            
get_event_guard_by_pair(S,D,CriteriaList) :-
    findall([E,G],
            (transition(S,D,E,G,_),
                E \= 'null',
                G \= 'null'),
    		CriteriaList).


get_system_state_pairs(PairsList) :-
    findall([S,D],
            (transition(S,D,_,_,_),
                S \= 'null',
                D \= 'null'),
            PairsList).

                     