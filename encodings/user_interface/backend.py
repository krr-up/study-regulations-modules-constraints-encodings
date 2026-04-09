
from clinguin.server.application.backends import ClingoBackend
from clinguin.utils.annotations import extends


class MyBackend(ClingoBackend):

    def __init__(self, args):
        self.constraint_set_unappended: set[str] = set()
        self.constraint_set_appended: set[str] = set()
        self.checked_pref: set[str] = set()
        self.checked_off: set[str] = set()

        super().__init__(args)

    #@property
    #def _ds_my_custom_constructor(self):
        # Creates custom program
    #    return "my_custom_program."
    
    @extends(ClingoBackend)
    def _init_ds_constructors(self):
        super()._init_ds_constructors()
        self._add_domain_state_constructor("_ds_constraint")

    def refresh_backend(self):
        self._outdate()
        self._init_ctl()
        self._ground()
        
    def remove_add_constraint(self, appended_str):
        " Used for the off/on  toggling of constraints. "

        print("def remove_add_constraint")
        # This handles the checkbox toggling.        
        if appended_str in self.checked_off:
            self.checked_off.remove(appended_str)
        elif appended_str not in self.checked_off:
            self.checked_off.add(appended_str)

        if appended_str in self.checked_off:
            appended_str = appended_str[1:-1]
            unappended_str = appended_str.split(",_")

            print("Removed:")
            print(unappended_str)        

            for ft in unappended_str:
                self.constraint_set_unappended.remove(ft)

        elif appended_str not in self.checked_off:
            appended_str = appended_str[1:-1]
            unappended_str = appended_str.split(",_")

            print("Added:")
            print(unappended_str)        

            for ft in unappended_str:
                self.constraint_set_unappended.add(ft)

    def add_constraint(self, appended_str):
        "Extracts constraints and adds it to constraints set."

        print("def add_constraint")

        appended_str = appended_str.replace("1000", "#sup")
        appended_str = appended_str[1:-1]
        unappended_str = appended_str.split(",_")
        
        # Add to appended set
        self.constraint_set_appended.add(appended_str)

        for ft in unappended_str:
            self.constraint_set_unappended.add(ft)

        self.refresh_backend()

    def off_constraint(self, appended_str):
        " Off constraint. "

        #self.remove_add_constraint(appended_str)

        # This handles the checkbox toggling.        
        if appended_str in self.checked_off:
            self.checked_off.remove(appended_str)
            print(">>rmv")
            print(appended_str)
        elif appended_str not in self.checked_off:
            self.checked_off.add(appended_str)
            print("<<<add")
            print(appended_str)

        if appended_str in self.checked_off:
            appended_str = appended_str[1:-1]
            unappended_str = appended_str.split(",_")

            print("Removed (off_constraint):")
            print(unappended_str)

            for ft in unappended_str:
                self.constraint_set_unappended.remove(ft)

        elif appended_str not in self.checked_off:
            appended_str = appended_str[1:-1]
            unappended_str = appended_str.split(",_")

            print("Added (off_constraint):")
            print(unappended_str)        

            for ft in unappended_str:
                self.constraint_set_unappended.add(ft)

        print("self.checked_off:")
        print(self.checked_off) 

        self.refresh_backend()
    
    def make_preference(self, appended_str):
        " Convert hard constraint into the associated preference. "

        #self.remove_add_constraint(appended_str)
        # This handles the checkbox toggling. 
        
        appended_str_with_braces_removed = appended_str[1:-1]
        unappended_str = appended_str_with_braces_removed.split(",_")  

        for ft in unappended_str:
            if ft in self.checked_pref:
                self.checked_pref.remove(ft)
                if appended_str in self.checked_pref:
                    print(f' in >> {appended_str}')
                    print(self.checked_pref)
                    self.checked_pref.remove(appended_str)

            elif ft not in self.checked_pref:
                self.checked_pref.add(ft)
                if appended_str not in self.checked_pref:
                    print(f' not in >> {appended_str}')
                    print(self.checked_pref)
                    self.checked_pref.add(appended_str)
                    
        self.refresh_backend()

    def remove_constraint(self, appended_str):
        " Remove constraint. "

        appended_str = appended_str[1:-1]

        # First remove from "appended set" - the display set
        self.constraint_set_appended.remove(appended_str)

        unappended_str = appended_str.split(",_")    

        for ft in unappended_str:
            self.constraint_set_unappended.remove(ft)
            print(ft)

        self.refresh_backend()

    def clear_all_constraints(self):
        " Clears all the constraints in the constraint list. "
        self.constraint_set_appended.clear()
        self.constraint_set_unappended.clear()
        self.checked_off.clear()
        self.checked_pref.clear()

        self.refresh_backend()

    @extends(ClingoBackend)
    def _load_and_add(self):
        super()._load_and_add()
        print("%%%%%")

        if self.constraint_set_unappended:
            constraint_str = "\n".join(f"{ft}." for ft in self.constraint_set_unappended)
            print("+++")
            print(constraint_str)
            self._ctl.add("base", [], constraint_str)
  
        if self.checked_pref:
            checked_pref_str = "\n".join(f"checked_pref({ft})." for ft in self.checked_pref)
            print(checked_pref_str)
            self._ctl.add("base", [], checked_pref_str)
      
        if self.checked_off:
            checked_off_str = "\n".join(f"checked_off({ft})." for ft in self.checked_off)
            print(checked_off_str)
            self._ctl.add("base", [], checked_off_str)

    @property
    def _ds_constraint(self):
        checked_pref_str = ""

        ui_constraint = "\n".join(f"_ui_constraint(({ft}))." for ft in self.constraint_set_appended)
        print(ui_constraint)
        print(self.constraint_set_appended) 
        print(self.checked_off)      
        
        checked_pref_str = "\n".join(f"_ui_checked_pref({ft})." for ft in self.checked_pref)
        print(checked_pref_str)
        
        checked_off_str = "\n".join(f"_ui_checked_off({ft})." for ft in self.checked_off)
        print(checked_off_str)

        return f'{ui_constraint} {checked_pref_str} {checked_off_str}'
    
        
