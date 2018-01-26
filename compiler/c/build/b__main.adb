pragma Ada_95;
pragma Warnings (Off);
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exception_table_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exceptions_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__secondary_stack_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "ada__containers_E");
   E065 : Short_Integer; pragma Import (Ada, E065, "ada__io_exceptions_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "ada__strings_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "interfaces__c_E");
   E077 : Short_Integer; pragma Import (Ada, E077, "system__os_lib_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "system__task_info_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__tags_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "ada__streams_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "system__file_control_block_E");
   E073 : Short_Integer; pragma Import (Ada, E073, "system__finalization_root_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "ada__finalization_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "system__file_io_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "system__storage_pools_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "system__finalization_masters_E");
   E132 : Short_Integer; pragma Import (Ada, E132, "system__storage_pools__subpools_E");
   E062 : Short_Integer; pragma Import (Ada, E062, "ada__text_io_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "ada__strings__maps_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "ada__strings__unbounded_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "ada__real_time_E");
   E160 : Short_Integer; pragma Import (Ada, E160, "system__tasking__initialization_E");
   E148 : Short_Integer; pragma Import (Ada, E148, "system__tasking__protected_objects_E");
   E156 : Short_Integer; pragma Import (Ada, E156, "system__tasking__protected_objects__entries_E");
   E168 : Short_Integer; pragma Import (Ada, E168, "system__tasking__queuing_E");
   E176 : Short_Integer; pragma Import (Ada, E176, "system__tasking__stages_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "buffers_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "character_utils_E");
   E082 : Short_Integer; pragma Import (Ada, E082, "lexer_E");
   E178 : Short_Integer; pragma Import (Ada, E178, "preprocessor_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "preprocessor__finalize_body");
      begin
         E178 := E178 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "lexer__finalize_body");
      begin
         E082 := E082 - 1;
         F2;
      end;
      E156 := E156 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F3;
      end;
      E120 := E120 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "ada__strings__unbounded__finalize_spec");
      begin
         F4;
      end;
      E062 := E062 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "ada__text_io__finalize_spec");
      begin
         F5;
      end;
      E132 := E132 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "system__storage_pools__subpools__finalize_spec");
      begin
         F6;
      end;
      E134 := E134 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__finalization_masters__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__file_io__finalize_body");
      begin
         E070 := E070 - 1;
         F8;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, True, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (True, False, False, True, True, False, False, False, 
           False, False, False, True, True, True, False, False, 
           True, False, False, True, True, False, True, True, 
           False, True, True, True, True, False, False, False, 
           False, False, True, False, False, True, False, True, 
           False, True, True, False, False, False, True, True, 
           False, False, True, False, False, False, False, False, 
           False, False, True, True, True, True, True, False, 
           False, True, False, True, True, True, False, True, 
           True, False, True, True, True, True, False, True, 
           True, False, False, False, True, True, True, True, 
           False, True, False),
         Count => (0, 0, 0, 2, 2, 1, 2, 0, 2, 0),
         Unknown => (False, False, False, False, False, False, False, False, True, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E023 := E023 + 1;
      System.Exceptions'Elab_Spec;
      E025 := E025 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Secondary_Stack'Elab_Body;
      E017 := E017 + 1;
      Ada.Containers'Elab_Spec;
      E179 := E179 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E065 := E065 + 1;
      Ada.Strings'Elab_Spec;
      E118 := E118 + 1;
      Interfaces.C'Elab_Spec;
      E075 := E075 + 1;
      System.Os_Lib'Elab_Body;
      E077 := E077 + 1;
      System.Task_Info'Elab_Spec;
      E103 := E103 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E006 := E006 + 1;
      Ada.Streams'Elab_Spec;
      E064 := E064 + 1;
      System.File_Control_Block'Elab_Spec;
      E080 := E080 + 1;
      System.Finalization_Root'Elab_Spec;
      E073 := E073 + 1;
      Ada.Finalization'Elab_Spec;
      E071 := E071 + 1;
      System.File_Io'Elab_Body;
      E070 := E070 + 1;
      System.Storage_Pools'Elab_Spec;
      E138 := E138 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E134 := E134 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E132 := E132 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E062 := E062 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E124 := E124 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E120 := E120 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E084 := E084 + 1;
      System.Tasking.Initialization'Elab_Body;
      E160 := E160 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E148 := E148 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E156 := E156 + 1;
      System.Tasking.Queuing'Elab_Body;
      E168 := E168 + 1;
      System.Tasking.Stages'Elab_Body;
      E176 := E176 + 1;
      E146 := E146 + 1;
      E181 := E181 + 1;
      Lexer'Elab_Body;
      E082 := E082 + 1;
      Preprocessor'Elab_Body;
      E178 := E178 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/louis/projects/lab/compiler/c/build/buffers.o
   --   /home/louis/projects/lab/compiler/c/build/character_utils.o
   --   /home/louis/projects/lab/compiler/c/build/lexer.o
   --   /home/louis/projects/lab/compiler/c/build/preprocessor.o
   --   /home/louis/projects/lab/compiler/c/build/main.o
   --   -L/home/louis/projects/lab/compiler/c/build/
   --   -L/home/louis/projects/lab/compiler/c/build/
   --   -L/usr/lib/gcc/x86_64-pc-linux-gnu/7.2.1/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -lpthread
   --   -lrt
--  END Object file/option list   

end ada_main;
