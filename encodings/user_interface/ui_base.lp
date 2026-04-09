#include "study_plans.lp".
#include "sidebar.lp".
#include "sidebar_2.lp".

% ==================== Main Window ====================

elem(main_window, window, root).
attr(main_window, flex_direction, row).

elem(main_content, container, main_window).
attr(main_content, order, 1).
%attr(main_content, class, ("flex-grow-1";"d-flex";"flex-column";"overflow-auto")).
attr(main_content, class, ("d-flex";"overflow-auto")).

% ==================== Menu Bar ====================

elem(menu_bar, menu_bar, main_window).
attr(menu_bar, title, "University Study Regulations - for student user").
attr(menu_bar, icon, "fa-graduation-cap").

elem(next_solution_button, button, menu_bar).
attr(next_solution_button, order, 1).
attr(next_solution_button, label, "Next Solution").
attr(next_solution_button, icon, "fa-arrow-right").
when(next_solution_button, click, call, next_solution(optN)).

elem(clear_assumptions_button, button, menu_bar).
attr(clear_assumptions_button, order, 3).
attr(clear_assumptions_button, label, "Clear").
attr(clear_assumptions_button, icon, "fa-eraser").
when(clear_assumptions_button, click, call, clear_assumptions).

% use this to run
% clinguin client-server --domain-files encoding.lp cogsys.lp --ui-files user_interface/ui_base.lp --custom-classes user_interface/backend.py --backend MyBackend -c n=4
