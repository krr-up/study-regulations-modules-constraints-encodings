% ==================== Sidebar container ====================

elem(side_2, sidebar, main_window).
attr(side_2, title, ".").
%attr(side_2, position, top).
%attr(side, order, 2).
%attr(side_2, class, "bg-light").
%attr(side_2, width, "300").

elem(sidebar_content_2, container, side_2).
%attr(sidebar_content_2, order, 2).
%attr(sidebar_content_2, class, ("p-4";"d-flex";"flex-column-reverse";"gap-4")).
attr(sidebar_content_2, class, ("d-flex";"flex-column";"gap-3")).

% ==================== Sidebar content ====================

elem(active_constraints_section_2, container, sidebar_content_2).
attr(active_constraints_section_2, order, 5).
attr(active_constraints_section_2, class, ("p-4";"bg-white";"rounded";"border";"shadow-sm")).

% === Active constraints section ===

elem(active_constraints_header_2, label, active_constraints_section_2).
attr(active_constraints_header_2, order, 1).

elem(active_constraints_2, container, active_constraints_section_2).

elem(active_constraints_section_header_2, label, active_constraints_2).
attr(active_constraints_section_header_2, order, 1).
attr(active_constraints_section_header_2, label, "-> Active constraints <-").
attr(active_constraints_section_header_2, class, ("fw-bold";"mb-3")).

elem(constraints_set_2, container, active_constraints_section_2).
attr(constraints_set_2, order, 2).
attr(constraints_set_2, class, "d-flex").

% Constraints List

elem(active_constraints_list, container, active_constraints_section_2) :- _ui_constraint(_).
attr(active_constraints_list, order, 3) :- _ui_constraint(_).
attr(active_constraints_list, class, ("d-flex";"flex-column";"gap-2";"bg-info-subtle")) :- _ui_constraint(_).

elem(constraint_list_item(C), container, active_constraints_list) :- _ui_constraint(C).
%elem(@concat("hello",constraint_list_item(C)), container, active_constraints_list) :- _ui_constraint(C).
attr(constraint_list_item(C), order, 1) :- _ui_constraint(C).
attr(constraint_list_item(C), class, ("d-flex";"justify-content-between";"align-items-center";"p-2";"bg-light";"bg-opacity-50";"rounded";"border";"mb-1")) :- _ui_constraint(C).
%attr(constraint_list_item(C), class, ("mb-1")) :- _ui_constraint(C).

elem(constraint_display_text(C), label, constraint_list_item(C)) :- _ui_constraint(C).
attr(constraint_display_text(C), order, 1) :- _ui_constraint(C).

% semester to ECTS credit
%attr(constraint_display_text(C), label, @concat("I want semester ",S," to have between ",L," and ",U, " ECTS credits.")) :- map(scl,S,L), map(scu,S,U), _ui_constraint(C).
attr(constraint_display_text(C), label, @concat("Semester ",S," has between ",L," and ",U, " ECTS credits.")) :- _ui_constraint(C), C = (map(scl,S,L),_map(scu,S,U)).
% module to semester
attr(constraint_display_text(C), label, @concat("Module ",M," is between semester ",L," and ",U, ".")) :- _ui_constraint(C), C = (map(msl,M,L),_map(msu,M,U)).
% semester to number of modules
attr(constraint_display_text(C), label, @concat("Semester ",I," has between ",L," and ",U, " number of modules.")) :- _ui_constraint(C), C = (map(sml,I,L),_map(smu,I,U)).
% number of semesters bound
attr(constraint_display_text(C), label, @concat("Study for between ",L," and ",U, " semesters.")) :- _ui_constraint(C), C = (map(sl,L),_map(su,U)).

attr(constraint_display_text(C), class, ("big";"mb-0";"fw-bold")) :- _ui_constraint(C).

% default 'hard constraint' checkbox
elem(hard_constraint_radio(C), checkbox, constraint_list_item(C)) :- _ui_constraint(C).
attr(hard_constraint_radio(C), label, "Enforce") :- _ui_constraint(C).
attr(hard_constraint_radio(C), order, 2) :- _ui_constraint(C).
attr(hard_constraint_radio(C), checked, true) :- _ui_constraint(C), not _ui_checked_pref(C).
when(hard_constraint_radio(C), click, call, add_constraint(C)) :- not checked_pref(C), _ui_constraint(C).
when(hard_constraint_radio(C), click, call, make_preference(C)) :- _ui_constraint(C).

% 'preference' checkbox
elem(make_preference_buttonx(C), checkbox, constraint_list_item(C)) :- _ui_constraint(C).
attr(make_preference_buttonx(C), label, "Soften") :- _ui_constraint(C).
attr(make_preference_buttonx(C), order, 2) :- _ui_constraint(C).
attr(make_preference_buttonx(C), checked, true) :- _ui_constraint(C), _ui_checked_pref(C).
when(make_preference_buttonx(C), click, call, make_preference(C)) :- _ui_constraint(C).

% "off/on" constraint checkbox
elem(off_constraint_button(C), checkbox, constraint_list_item(C)) :- _ui_constraint(C).
attr(off_constraint_button(C), order, 2) :- _ui_constraint(C).
attr(off_constraint_button(C), label, "Off") :- _ui_constraint(C).
attr(off_constraint_button(C), checked, true) :- _ui_checked_off(C), _ui_constraint(C).
attr(constraint_list_item(C), class, "bg-opacity-20") :- checked_off(C), _ui_constraint(C).
when(off_constraint_button(C), click, call, off_constraint(C)) :- _ui_constraint(C).

% remove constraint button
elem(constraint_remove_button(C), button, constraint_list_item(C)) :- _ui_constraint(C).
attr(constraint_remove_button(C), order, 2) :- _ui_constraint(C).
attr(constraint_remove_button(C), icon, "fa-times") :- _ui_constraint(C).
attr(constraint_remove_button(C), disabled, true) :- _ui_checked_off(C), _ui_constraint(C).
attr(constraint_remove_button(C), disabled, true) :- _ui_checked_pref(C), _ui_constraint(C).
attr(constraint_remove_button(C), class, ("btn";"btn-sm";"btn-danger")) :- _ui_constraint(C).
when(constraint_remove_button(C), click, call, remove_constraint(C)) :- _ui_constraint(C).

elem(clear_all_constraints_button, button, active_constraints_section_2) :- _ui_constraint(_).
attr(clear_all_constraints_button, order, 4) :- _ui_constraint(_).
attr(clear_all_constraints_button, label, "Clear all constraints") :- _ui_constraint(_).
attr(clear_all_constraints_button, icon, "fa-trash") :- _ui_constraint(_).
attr(clear_all_constraints_button, disabled, true) :- _ui_checked_off(_), _ui_constraint(_).
attr(clear_all_constraints_button, disabled, true) :- _ui_checked_pref(_), _ui_constraint(_).
attr(clear_all_constraints_button, class, ("btn";"btn-sm";"btn-danger";"w-100";"mt-3")) :- _ui_constraint(_).
when(clear_all_constraints_button, click, call, clear_all_constraints) :- _ui_constraint(_).

