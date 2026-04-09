% hard constraint  
% if semester I is in a solution, then the total count of the modules in I must be
% between L and U.
:- in(_,s(I)), map(scl,I,L), map(scu,I,U), not L #sum{ V,M : in(M,s(I)), map(c,M,V) } U,
    not checked_pref(map(scl,I,L)), not checked_pref(map(scu,I,U)).

% soft constraint  : distance to bound L and U (dtb)
map(dtb,I,D) :- in(_,s(I)), map(scl,I,L), map(scu,I,U), 
                X = #sum{ V,M : in(M,s(I)), map(c,M,V) }, X < L, D = L - X.
map(dtb,I,D) :- in(_,s(I)), map(scl,I,L), map(scu,I,U), 
                X = #sum{ V,M : in(M,s(I)), map(c,M,V) }, X > U, D = X - U.

#minimize{ D,I: map(dtb,I,D), map(scl,I,L), checked_pref(map(scl,I,L)), 
                              map(scu,I,U), checked_pref(map(scu,I,U)) }.