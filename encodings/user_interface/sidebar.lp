% ==================== Sidebar container ====================

elem(side, sidebar, main_window).
attr(side, title, "Set constraints").
attr(side, position, end).
attr(side, order, 1).
attr(side, class, "bg-light").
attr(side, width, "400").


elem(sidebar_content, container, side).
attr(sidebar_content, order, 1).
attr(sidebar_content, class, ("p-4";"d-flex";"flex-column";"gap-4")).

% ==================== Sidebar content ====================

elem(semester_to_ECTS_constraints_management_section, container, sidebar_content).
attr(semester_to_ECTS_constraints_management_section, order, 1).
attr(semester_to_ECTS_constraints_management_section, class, ("p-4";"bg-white";"rounded";"border";"shadow-sm")).

elem(module_to_semester_constraints_management_section, container, sidebar_content).
attr(module_to_semester_constraints_management_section, order, 2).
attr(module_to_semester_constraints_management_section, class, ("p-4";"bg-white";"rounded";"border";"shadow-sm")).

elem(stnm_constraints_management_section, container, sidebar_content).
attr(stnm_constraints_management_section, order, 3).
attr(stnm_constraints_management_section, class, ("p-4";"bg-white";"rounded";"border";"shadow-sm")).

elem(nos_constraints_management_section, container, sidebar_content).
attr(nos_constraints_management_section, order, 4).
attr(nos_constraints_management_section, class, ("p-4";"bg-white";"rounded";"border";"shadow-sm")).
%*
elem(active_constraints_section, container, sidebar_content).
attr(active_constraints_section, order, 5).
attr(active_constraints_section, class, ("p-4";"bg-white";"rounded";"border";"shadow-sm")).
*%
% === semester_to_ECTS credits constraints management section ===

elem(semester_to_ECTS_management_header, label, semester_to_ECTS_constraints_management_section).
attr(semester_to_ECTS_management_header, order, 1).

% === Constraint semester-to-ECTS credits bound (ste) ===

elem(semester_to_ECTS_section, container, semester_to_ECTS_constraints_management_section).

elem(ste_input_set, container, semester_to_ECTS_constraints_management_section).
elem(ste_input_setb, container, semester_to_ECTS_constraints_management_section).
attr(ste_input_set, order, 2).
attr(ste_input_set, class, ("d-flex";"flex-row")).
elem(ste_input_setb, container, semester_to_ECTS_constraints_management_section).
attr(ste_input_setb, order, 3).
attr(ste_input_setb, class, "d-flex").

elem(semester_to_ECTS_header, label, semester_to_ECTS_section).
attr(semester_to_ECTS_header, order, 1).
attr(semester_to_ECTS_header, label, "Semester-to-ECTS credits bound").
attr(semester_to_ECTS_header, class, ("fw-bold";"mb-3")).

% Semester input
elem(ste_semester, textfield, ste_input_set).
attr(ste_semester, order, 1).
attr(ste_semester, placeholder, "semester").
attr(ste_semester, class, "form-control").
when(ste_semester, input, context, (ste_semester, _value)).

% Lower-bound
elem(ste_lower_bound, textfield, ste_input_set).
attr(ste_lower_bound, order, 2).
attr(ste_lower_bound, placeholder, "lowerbound").
attr(ste_lower_bound, class, "form-control").
when(ste_lower_bound, input, context, (ste_lower_bound, _value)).

% Upper-bound
elem(ste_upper_bound, textfield, ste_input_set).
attr(ste_upper_bound, order, 3).
attr(ste_upper_bound, placeholder, "upperbound").
attr(ste_upper_bound, class, "form-control").
when(ste_upper_bound, input, context, (ste_upper_bound,_value)).

% add constraint button
elem(ste_input_button, button, ste_input_setb).
attr(ste_input_button, label, "Set constraint").
attr(ste_input_button, order, 4).
attr(ste_input_button, class, ("btn";"btn-sm";"btn-outline-success";"w-100")).
when(ste_input_button, click, call, 
    add_constraint(@concat("(map(scl,", _context_value(ste_semester, int), 
    ",", _context_value(ste_lower_bound, int, 0), ") , _map(scu,", _context_value(ste_semester, int), ",", _context_value(ste_upper_bound, int, 1000),"))"))).


% === module_to_semester constraints management section ===

elem(module_to_semester_constraints_management_header, label, module_to_semester_constraints_management_section).
attr(module_to_semester_constraints_management_header, order, 1).

% === Constraint module-to-semester bound (mts) ===

elem(module_to_semester_section, container, module_to_semester_constraints_management_section).

elem(mts_input_set, container, module_to_semester_constraints_management_section).
attr(mts_input_set, order, 2).
attr(mts_input_set, class, ("d-flex";"flex-row")).

elem(mts_input_set_button, container, module_to_semester_constraints_management_section).
attr(mts_input_set_button, order, 3).
attr(mts_input_set_button, class, "d-flex").

elem(module_to_semester_header, label, module_to_semester_section).
attr(module_to_semester_header, order, 1).
attr(module_to_semester_header, label, "Module-to-semester bound").
attr(module_to_semester_header, class, ("fw-bold";"mb-3")).

% Module input
elem(mts_module, textfield, mts_input_set).
attr(mts_module, order, 1).
attr(mts_module, placeholder, "module").
attr(mts_module, class, "form-control").
when(mts_module, input, context, (mts_module, _value)).

% Lower-bound
elem(mts_lower_bound, textfield, mts_input_set).
attr(mts_lower_bound, order, 2).
attr(mts_lower_bound, placeholder, "lowerbound").
attr(mts_lower_bound, class, "form-control").
when(mts_lower_bound, input, context, (mts_lower_bound, _value)).

% Upper-bound
elem(mts_upper_bound, textfield, mts_input_set).
attr(mts_upper_bound, order, 3).
attr(mts_upper_bound, placeholder, "upperbound").
attr(mts_upper_bound, class, "form-control").
when(mts_upper_bound, input, context, (mts_upper_bound,_value)).

% add constraint button
elem(mts_input_button, button, mts_input_set_button).
attr(mts_input_button, label, "Set constraint").
attr(mts_input_button, order, 4).
attr(mts_input_button, class, ("btn";"btn-sm";"btn-outline-success";"w-100")).
when(mts_input_button, click, call, 
    add_constraint(@concat("(map(msl,", _context_value(mts_module, const), 
    ",", _context_value(mts_lower_bound, int, 0), ") , _map(msu,", _context_value(mts_module, const), ",", _context_value(mts_upper_bound, int, 1000),"))"))).


% === semester-to-number constraints management section ===

elem(stnm_constraints_management_header, label, stnm_constraints_management_section).
attr(stnm_constraints_management_header, order, 1).

% === Constraint semester-to-number of modules bound (stnm) ===

elem(semester_to_number_of_modules_section, container, stnm_constraints_management_section).

elem(stnm_input_set, container, stnm_constraints_management_section).
attr(stnm_input_set, order, 2).
attr(stnm_input_set, class, ("d-flex";"flex-row")).

elem(stnm_input_set_button, container, stnm_constraints_management_section).
attr(stnm_input_set_button, order, 3).
attr(stnm_input_set_button, class, "d-flex").

elem(semester_to_number_of_modules_header, label, semester_to_number_of_modules_section).
attr(semester_to_number_of_modules_header, order, 1).
attr(semester_to_number_of_modules_header, label, "Semester-to-number of modules bound").
attr(semester_to_number_of_modules_header, class, ("fw-bold";"mb-3")).

% Semester input
elem(stnm_semester, textfield, stnm_input_set).
attr(stnm_semester, order, 1).
attr(stnm_semester, placeholder, "semester").
attr(stnm_semester, class, "form-control").
when(stnm_semester, input, context, (stnm_semester, _value)).

% Lower-bound
elem(stnm_lower_bound, textfield, stnm_input_set).
attr(stnm_lower_bound, order, 2).
attr(stnm_lower_bound, placeholder, "lowerbound").
attr(stnm_lower_bound, class, "form-control").
when(stnm_lower_bound, input, context, (stnm_lower_bound, _value)).

% Upper-bound
elem(stnm_upper_bound, textfield, stnm_input_set).
attr(stnm_upper_bound, order, 3).
attr(stnm_upper_bound, placeholder, "upperbound").
attr(stnm_upper_bound, class, "form-control").
when(stnm_upper_bound, input, context, (stnm_upper_bound,_value)).

% add constraint button
elem(stnm_input_button, button, stnm_input_set_button).
attr(stnm_input_button, label, "Set constraint").
attr(stnm_input_button, order, 4).
attr(stnm_input_button, class, ("btn";"btn-sm";"btn-outline-success";"w-100")).
when(stnm_input_button, click, call, 
    add_constraint(@concat("(map(sml,", _context_value(stnm_semester, int), 
    ",", _context_value(stnm_lower_bound, int, 0), ") , _map(smu,", _context_value(stnm_semester, int), ",", _context_value(stnm_upper_bound, int, 1000),"))"))).


% === number of semesters (nos) constraints management section ===

elem(nos_constraints_management_header, label, nos_constraints_management_section).
attr(nos_constraints_management_header, order, 1).

elem(nos_input_set_button, container, nos_constraints_management_section).
attr(nos_input_set_button, order, 3).
attr(nos_input_set_button, class, "d-flex").

% === Constraint nos bound  ===

elem(nos_section, container, nos_constraints_management_section).

elem(nos_input_set, container, nos_constraints_management_section).
attr(nos_input_set, order, 2).
attr(nos_input_set, class, ("d-flex";"flex-row")).

elem(nos_header, label, nos_section).
attr(nos_header, order, 1).
attr(nos_header, label, "Number of semesters bound").
attr(nos_header, class, ("fw-bold";"mb-3")).

% Lower-bound
elem(nos_lower_bound, textfield, nos_input_set).
attr(nos_lower_bound, order, 2).
attr(nos_lower_bound, placeholder, "lowerbound").
attr(nos_lower_bound, class, "form-control").
when(nos_lower_bound, input, context, (nos_lower_bound, _value)).

% Upper-bound
elem(nos_upper_bound, textfield, nos_input_set).
attr(nos_upper_bound, order, 3).
attr(nos_upper_bound, placeholder, "upperbound").
attr(nos_upper_bound, class, "form-control").
when(nos_upper_bound, input, context, (nos_upper_bound,_value)).

% add constraint button
elem(nos_input_button, button, nos_input_set_button).
attr(nos_input_button, label, "Set constraint").
attr(nos_input_button, order, 4).
attr(nos_input_button, class, ("btn";"btn-sm";"btn-outline-success";"w-100")).
when(nos_input_button, click, call, 
    add_constraint(@concat("(map(sl,", _context_value(nos_lower_bound, int), ") , _map(su,", _context_value(nos_upper_bound, int),"))"))).

% === Active constraints section ===
%*
elem(active_constraints_header, label, active_constraints_section).
attr(active_constraints_header, order, 1).

elem(active_constraints, container, active_constraints_section).

elem(active_constraints_section_header, label, active_constraints).
attr(active_constraints_section_header, order, 1).
attr(active_constraints_section_header, label, "-> Active constraints <-").
attr(active_constraints_section_header, class, ("fw-bold";"mb-3")).

elem(constraints_set, container, active_constraints_section).
attr(constraints_set, order, 2).
attr(constraints_set, class, "d-flex").

% Constraints List

elem(active_constraints_list, container, active_constraints_section) :- _ui_constraint(_).
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
attr(constraint_display_text(C), label, @concat("I want semester ",S," to have between ",L," and ",U, " ECTS credits.")) :- _ui_constraint(C), C = (map(scl,S,L),_map(scu,S,U)).
% module to semester
attr(constraint_display_text(C), label, @concat("I want module ",M," to be between semester ",L," and ",U, ".")) :- _ui_constraint(C), C = (map(msl,M,L),_map(msu,M,U)).
% semester to number of modules
attr(constraint_display_text(C), label, @concat("I want semester ",I," to have between ",L," and ",U, " number of modules.")) :- _ui_constraint(C), C = (map(sml,I,L),_map(smu,I,U)).
% number of semesters bound
attr(constraint_display_text(C), label, @concat("I want to study for between ",L," and ",U, " semesters.")) :- _ui_constraint(C), C = (map(sl,L),_map(su,U)).

attr(constraint_display_text(C), class, ("big";"mb-0";"fw-bold")) :- _ui_constraint(C).

% "off/on" constraint checkbox
elem(off_constraint_button(C), checkbox, constraint_list_item(C)) :- _ui_constraint(C).
attr(off_constraint_button(C), order, 2) :- _ui_constraint(C).
attr(off_constraint_button(C), label, "Off") :- _ui_constraint(C).
attr(off_constraint_button(C), checked, true) :- checked_off(C), _ui_constraint(C).
%attr(off_constraint_button(C), icon, "fa-power-off") :- _ui_constraint(C).
%attr(off_constraint_button(C), class, ("btn";"btn-check";"btn-sm";"btn-dark")) :- _ui_constraint(C).
when(off_constraint_button(C), click, call, off_constraint(C)) :- _ui_constraint(C).
%when(off_constraint_button(C), click, call, off_constraint(C)) :- _ui_constraint(C).

% convert to preference checkbox
elem(make_preference_button(C), checkbox, constraint_list_item(C)) :- _ui_constraint(C).
attr(make_preference_button(C), order, 2) :- _ui_constraint(C).
attr(make_preference_button(C), label, "Make preference") :- _ui_constraint(C).
attr(make_preference_button(C), checked, true) :- checked_pref(C), _ui_constraint(C).
%attr(make_preference_button(C), checked, false) :- _ui_constraint(C), not checked_pref(C).
%attr(make_preference_button(C), icon, "fa-tint") :- _ui_constraint(C).
%attr(make_preference_button(C), class, ("btn";"btn-sm";"btn-secondary")) :- _ui_constraint(C).
when(make_preference_button(C), click, call, make_preference(C)) :- _ui_constraint(C).

% remove constraint button
elem(constraint_remove_button(C), button, constraint_list_item(C)) :- _ui_constraint(C).
attr(constraint_remove_button(C), order, 2) :- _ui_constraint(C).
attr(constraint_remove_button(C), icon, "fa-times") :- _ui_constraint(C).
attr(constraint_remove_button(C), class, ("btn";"btn-sm";"btn-danger")) :- _ui_constraint(C).
when(constraint_remove_button(C), click, call, remove_constraint(C)) :- _ui_constraint(C).

elem(clear_all_constraints_button, button, active_constraints_section) :- _ui_constraint(_).
attr(clear_all_constraints_button, order, 4) :- _ui_constraint(_).
attr(clear_all_constraints_button, label, "Clear all constraints") :- _ui_constraint(_).
attr(clear_all_constraints_button, icon, "fa-trash") :- _ui_constraint(_).
attr(clear_all_constraints_button, class, ("btn";"btn-sm";"btn-danger";"w-100";"mt-3")) :- _ui_constraint(_).
when(clear_all_constraints_button, click, call, clear_all_constraints) :- _ui_constraint(_).
*%