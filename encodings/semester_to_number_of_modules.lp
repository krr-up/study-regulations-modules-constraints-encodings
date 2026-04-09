% hard constraint - 
% if semester I is in a solution, then the total count of the modules in I must 
% be between L and U.
:- in(_,s(I)), map(sml,I,L), map(smu,I,U), not L #count{M : in(M,s(I)) } U.

% soft constraint  : distance to L and U bound (dtb) -
map(dtb,I,D) :- in(_,s(I)), map(sml,I,L), X = #count{ M: in(M,s(I)) }, X < L,
                D = L - X, not checked_pref(map(sml,I,L)).
map(dtb,I,D) :- in(_,s(I)), map(smu,I,U), X = #count{ M: in(M,s(I)) }, X > U,
                D = X - U, not checked_pref(map(smu,I,U)).

#minimize{ D,I: map(dtb,I,D), map(sml,I,L), checked_pref(map(sml,I,L)), 
                              map(smu,I,U), checked_pref(map(smu,I,U)) }.