% hard constraint
:- map(sl,L), n < L, not checked_pref(map(sl,L)).
:- map(su,U), n > U, not checked_pref(map(su,U)).

% soft constraint  : distance to bound L and U (dtb) -
map(dtb,D) :- map(sl,L), map(su,U), n < L, D = L - n.
map(dtb,D) :- map(sl,L), map(su,U), n > U, D = n - U.

#minimize{ D: map(dtb,D), map(sl,L), checked_pref(map(sl,L)), 
                          map(su,U), checked_pref(map(su,U)) }.