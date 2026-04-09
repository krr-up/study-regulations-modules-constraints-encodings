% -- mi set
in(M,mi) :- map(msl,M,_).
in(M,mi) :- map(msu,M,_).

% -- hard constraint
:- in(M,mi), not in(M,s(_)).

:- in(M,s(I)), map(msl,M,L), I < L, not checked_pref(map(msl,M,L)).
:- in(M,s(I)), map(msu,M,U), I > U, not checked_pref(map(msl,M,U)).

% -- soft : distance to bound L and U (dtb) -
map(dtb,M,D) :- in(M,s(X)), in(M,mi), map(msl,M,L), map(msu,M,U), X < L, D = L - X.
map(dtb,M,D) :- in(M,s(X)), in(M,mi), map(msl,M,L), map(msu,M,U), X > U, D = X - U.

#minimize{ D,M: map(dtb,M,D), map(msl,M,L), checked_pref(map(msl,M,L)),
                              map(msl,M,U), checked_pref(map(msl,M,U)) }.