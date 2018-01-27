pragma Ada_95;
pragma Warnings (Off);
with System;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: 7.2.1 20171224" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#212cf3a1#;
   pragma Export (C, u00001, "mainB");
   u00002 : constant Version_32 := 16#b6df930e#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#7ec093d3#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#c2326fda#;
   pragma Export (C, u00005, "ada__exceptionsB");
   u00006 : constant Version_32 := 16#6e98a13f#;
   pragma Export (C, u00006, "ada__exceptionsS");
   u00007 : constant Version_32 := 16#e947e6a9#;
   pragma Export (C, u00007, "ada__exceptions__last_chance_handlerB");
   u00008 : constant Version_32 := 16#41e5552e#;
   pragma Export (C, u00008, "ada__exceptions__last_chance_handlerS");
   u00009 : constant Version_32 := 16#4635ec04#;
   pragma Export (C, u00009, "systemS");
   u00010 : constant Version_32 := 16#4e7785b8#;
   pragma Export (C, u00010, "system__soft_linksB");
   u00011 : constant Version_32 := 16#d8b13451#;
   pragma Export (C, u00011, "system__soft_linksS");
   u00012 : constant Version_32 := 16#b01dad17#;
   pragma Export (C, u00012, "system__parametersB");
   u00013 : constant Version_32 := 16#381fe17b#;
   pragma Export (C, u00013, "system__parametersS");
   u00014 : constant Version_32 := 16#30ad09e5#;
   pragma Export (C, u00014, "system__secondary_stackB");
   u00015 : constant Version_32 := 16#fca7137e#;
   pragma Export (C, u00015, "system__secondary_stackS");
   u00016 : constant Version_32 := 16#f103f468#;
   pragma Export (C, u00016, "system__storage_elementsB");
   u00017 : constant Version_32 := 16#6bf6a600#;
   pragma Export (C, u00017, "system__storage_elementsS");
   u00018 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00018, "system__stack_checkingB");
   u00019 : constant Version_32 := 16#c88a87ec#;
   pragma Export (C, u00019, "system__stack_checkingS");
   u00020 : constant Version_32 := 16#87a448ff#;
   pragma Export (C, u00020, "system__exception_tableB");
   u00021 : constant Version_32 := 16#1b9b8546#;
   pragma Export (C, u00021, "system__exception_tableS");
   u00022 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00022, "system__exceptionsB");
   u00023 : constant Version_32 := 16#2e5681f2#;
   pragma Export (C, u00023, "system__exceptionsS");
   u00024 : constant Version_32 := 16#843d48dc#;
   pragma Export (C, u00024, "system__exceptions__machineS");
   u00025 : constant Version_32 := 16#aa0563fc#;
   pragma Export (C, u00025, "system__exceptions_debugB");
   u00026 : constant Version_32 := 16#38bf15c0#;
   pragma Export (C, u00026, "system__exceptions_debugS");
   u00027 : constant Version_32 := 16#6c2f8802#;
   pragma Export (C, u00027, "system__img_intB");
   u00028 : constant Version_32 := 16#44ee0cc6#;
   pragma Export (C, u00028, "system__img_intS");
   u00029 : constant Version_32 := 16#39df8c17#;
   pragma Export (C, u00029, "system__tracebackB");
   u00030 : constant Version_32 := 16#181732c0#;
   pragma Export (C, u00030, "system__tracebackS");
   u00031 : constant Version_32 := 16#9ed49525#;
   pragma Export (C, u00031, "system__traceback_entriesB");
   u00032 : constant Version_32 := 16#466e1a74#;
   pragma Export (C, u00032, "system__traceback_entriesS");
   u00033 : constant Version_32 := 16#6fd210f2#;
   pragma Export (C, u00033, "system__traceback__symbolicB");
   u00034 : constant Version_32 := 16#dd19f67a#;
   pragma Export (C, u00034, "system__traceback__symbolicS");
   u00035 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00035, "ada__exceptions__tracebackB");
   u00036 : constant Version_32 := 16#20245e75#;
   pragma Export (C, u00036, "ada__exceptions__tracebackS");
   u00037 : constant Version_32 := 16#9f00b3d3#;
   pragma Export (C, u00037, "system__address_imageB");
   u00038 : constant Version_32 := 16#e7d9713e#;
   pragma Export (C, u00038, "system__address_imageS");
   u00039 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00039, "system__wch_conB");
   u00040 : constant Version_32 := 16#5d48ced6#;
   pragma Export (C, u00040, "system__wch_conS");
   u00041 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00041, "system__wch_stwB");
   u00042 : constant Version_32 := 16#7059e2d7#;
   pragma Export (C, u00042, "system__wch_stwS");
   u00043 : constant Version_32 := 16#a831679c#;
   pragma Export (C, u00043, "system__wch_cnvB");
   u00044 : constant Version_32 := 16#52ff7425#;
   pragma Export (C, u00044, "system__wch_cnvS");
   u00045 : constant Version_32 := 16#5ab55268#;
   pragma Export (C, u00045, "interfacesS");
   u00046 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00046, "system__wch_jisB");
   u00047 : constant Version_32 := 16#d28f6d04#;
   pragma Export (C, u00047, "system__wch_jisS");
   u00048 : constant Version_32 := 16#3d17c74c#;
   pragma Export (C, u00048, "ada__tagsB");
   u00049 : constant Version_32 := 16#5a4e344a#;
   pragma Export (C, u00049, "ada__tagsS");
   u00050 : constant Version_32 := 16#c3335bfd#;
   pragma Export (C, u00050, "system__htableB");
   u00051 : constant Version_32 := 16#c2f75fee#;
   pragma Export (C, u00051, "system__htableS");
   u00052 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00052, "system__string_hashB");
   u00053 : constant Version_32 := 16#60a93490#;
   pragma Export (C, u00053, "system__string_hashS");
   u00054 : constant Version_32 := 16#72b39087#;
   pragma Export (C, u00054, "system__unsigned_typesS");
   u00055 : constant Version_32 := 16#afdbf393#;
   pragma Export (C, u00055, "system__val_lluB");
   u00056 : constant Version_32 := 16#0841c7f5#;
   pragma Export (C, u00056, "system__val_lluS");
   u00057 : constant Version_32 := 16#27b600b2#;
   pragma Export (C, u00057, "system__val_utilB");
   u00058 : constant Version_32 := 16#ea955afa#;
   pragma Export (C, u00058, "system__val_utilS");
   u00059 : constant Version_32 := 16#d1060688#;
   pragma Export (C, u00059, "system__case_utilB");
   u00060 : constant Version_32 := 16#623c85d3#;
   pragma Export (C, u00060, "system__case_utilS");
   u00061 : constant Version_32 := 16#1d1c6062#;
   pragma Export (C, u00061, "ada__text_ioB");
   u00062 : constant Version_32 := 16#e1e47390#;
   pragma Export (C, u00062, "ada__text_ioS");
   u00063 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00063, "ada__streamsB");
   u00064 : constant Version_32 := 16#67e31212#;
   pragma Export (C, u00064, "ada__streamsS");
   u00065 : constant Version_32 := 16#92d882c5#;
   pragma Export (C, u00065, "ada__io_exceptionsS");
   u00066 : constant Version_32 := 16#4c01b69c#;
   pragma Export (C, u00066, "interfaces__c_streamsB");
   u00067 : constant Version_32 := 16#b1330297#;
   pragma Export (C, u00067, "interfaces__c_streamsS");
   u00068 : constant Version_32 := 16#36a43a0a#;
   pragma Export (C, u00068, "system__crtlS");
   u00069 : constant Version_32 := 16#d542d957#;
   pragma Export (C, u00069, "system__file_ioB");
   u00070 : constant Version_32 := 16#e1440d61#;
   pragma Export (C, u00070, "system__file_ioS");
   u00071 : constant Version_32 := 16#86c56e5a#;
   pragma Export (C, u00071, "ada__finalizationS");
   u00072 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00072, "system__finalization_rootB");
   u00073 : constant Version_32 := 16#09c79f94#;
   pragma Export (C, u00073, "system__finalization_rootS");
   u00074 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00074, "interfaces__cB");
   u00075 : constant Version_32 := 16#70be4e8c#;
   pragma Export (C, u00075, "interfaces__cS");
   u00076 : constant Version_32 := 16#957a1bdd#;
   pragma Export (C, u00076, "system__os_libB");
   u00077 : constant Version_32 := 16#5913ca02#;
   pragma Export (C, u00077, "system__os_libS");
   u00078 : constant Version_32 := 16#1a817b8e#;
   pragma Export (C, u00078, "system__stringsB");
   u00079 : constant Version_32 := 16#388afd62#;
   pragma Export (C, u00079, "system__stringsS");
   u00080 : constant Version_32 := 16#bbaa76ac#;
   pragma Export (C, u00080, "system__file_control_blockS");
   u00081 : constant Version_32 := 16#4eea072e#;
   pragma Export (C, u00081, "decomposingB");
   u00082 : constant Version_32 := 16#f8a74e44#;
   pragma Export (C, u00082, "decomposingS");
   u00083 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00083, "ada__stringsS");
   u00084 : constant Version_32 := 16#3791e504#;
   pragma Export (C, u00084, "ada__strings__unboundedB");
   u00085 : constant Version_32 := 16#9fdb1809#;
   pragma Export (C, u00085, "ada__strings__unboundedS");
   u00086 : constant Version_32 := 16#60da0992#;
   pragma Export (C, u00086, "ada__strings__searchB");
   u00087 : constant Version_32 := 16#c1ab8667#;
   pragma Export (C, u00087, "ada__strings__searchS");
   u00088 : constant Version_32 := 16#e2ea8656#;
   pragma Export (C, u00088, "ada__strings__mapsB");
   u00089 : constant Version_32 := 16#1e526bec#;
   pragma Export (C, u00089, "ada__strings__mapsS");
   u00090 : constant Version_32 := 16#e95cd909#;
   pragma Export (C, u00090, "system__bit_opsB");
   u00091 : constant Version_32 := 16#0765e3a3#;
   pragma Export (C, u00091, "system__bit_opsS");
   u00092 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00092, "ada__charactersS");
   u00093 : constant Version_32 := 16#4b7bb96a#;
   pragma Export (C, u00093, "ada__characters__latin_1S");
   u00094 : constant Version_32 := 16#933d1555#;
   pragma Export (C, u00094, "system__compare_array_unsigned_8B");
   u00095 : constant Version_32 := 16#ef369d89#;
   pragma Export (C, u00095, "system__compare_array_unsigned_8S");
   u00096 : constant Version_32 := 16#97d13ec4#;
   pragma Export (C, u00096, "system__address_operationsB");
   u00097 : constant Version_32 := 16#55395237#;
   pragma Export (C, u00097, "system__address_operationsS");
   u00098 : constant Version_32 := 16#a2250034#;
   pragma Export (C, u00098, "system__storage_pools__subpoolsB");
   u00099 : constant Version_32 := 16#cc5a1856#;
   pragma Export (C, u00099, "system__storage_pools__subpoolsS");
   u00100 : constant Version_32 := 16#6abe5dbe#;
   pragma Export (C, u00100, "system__finalization_mastersB");
   u00101 : constant Version_32 := 16#1dc9d5ce#;
   pragma Export (C, u00101, "system__finalization_mastersS");
   u00102 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00102, "system__img_boolB");
   u00103 : constant Version_32 := 16#b3ec9def#;
   pragma Export (C, u00103, "system__img_boolS");
   u00104 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00104, "system__ioB");
   u00105 : constant Version_32 := 16#d8771b4b#;
   pragma Export (C, u00105, "system__ioS");
   u00106 : constant Version_32 := 16#6d4d969a#;
   pragma Export (C, u00106, "system__storage_poolsB");
   u00107 : constant Version_32 := 16#65d872a9#;
   pragma Export (C, u00107, "system__storage_poolsS");
   u00108 : constant Version_32 := 16#9aad1ff1#;
   pragma Export (C, u00108, "system__storage_pools__subpools__finalizationB");
   u00109 : constant Version_32 := 16#fe2f4b3a#;
   pragma Export (C, u00109, "system__storage_pools__subpools__finalizationS");
   u00110 : constant Version_32 := 16#020a3f4d#;
   pragma Export (C, u00110, "system__atomic_countersB");
   u00111 : constant Version_32 := 16#f269c189#;
   pragma Export (C, u00111, "system__atomic_countersS");
   u00112 : constant Version_32 := 16#3c420900#;
   pragma Export (C, u00112, "system__stream_attributesB");
   u00113 : constant Version_32 := 16#8bc30a4e#;
   pragma Export (C, u00113, "system__stream_attributesS");
   u00114 : constant Version_32 := 16#5a5d08de#;
   pragma Export (C, u00114, "sourceB");
   u00115 : constant Version_32 := 16#a5c43c3a#;
   pragma Export (C, u00115, "sourceS");
   u00116 : constant Version_32 := 16#46899fd1#;
   pragma Export (C, u00116, "system__concat_7B");
   u00117 : constant Version_32 := 16#baf2b71b#;
   pragma Export (C, u00117, "system__concat_7S");
   u00118 : constant Version_32 := 16#a83b7c85#;
   pragma Export (C, u00118, "system__concat_6B");
   u00119 : constant Version_32 := 16#94f2c1b6#;
   pragma Export (C, u00119, "system__concat_6S");
   u00120 : constant Version_32 := 16#608e2cd1#;
   pragma Export (C, u00120, "system__concat_5B");
   u00121 : constant Version_32 := 16#c16baf2a#;
   pragma Export (C, u00121, "system__concat_5S");
   u00122 : constant Version_32 := 16#932a4690#;
   pragma Export (C, u00122, "system__concat_4B");
   u00123 : constant Version_32 := 16#3851c724#;
   pragma Export (C, u00123, "system__concat_4S");
   u00124 : constant Version_32 := 16#2b70b149#;
   pragma Export (C, u00124, "system__concat_3B");
   u00125 : constant Version_32 := 16#4d45b0a1#;
   pragma Export (C, u00125, "system__concat_3S");
   u00126 : constant Version_32 := 16#fd83e873#;
   pragma Export (C, u00126, "system__concat_2B");
   u00127 : constant Version_32 := 16#44953bd4#;
   pragma Export (C, u00127, "system__concat_2S");
   u00128 : constant Version_32 := 16#d6b9b60f#;
   pragma Export (C, u00128, "buffersB");
   u00129 : constant Version_32 := 16#83db28a8#;
   pragma Export (C, u00129, "buffersS");
   u00130 : constant Version_32 := 16#37a60d57#;
   pragma Export (C, u00130, "system__taskingB");
   u00131 : constant Version_32 := 16#c03b1874#;
   pragma Export (C, u00131, "system__taskingS");
   u00132 : constant Version_32 := 16#08881467#;
   pragma Export (C, u00132, "system__task_primitivesS");
   u00133 : constant Version_32 := 16#decff30d#;
   pragma Export (C, u00133, "system__os_interfaceB");
   u00134 : constant Version_32 := 16#dac51a48#;
   pragma Export (C, u00134, "system__os_interfaceS");
   u00135 : constant Version_32 := 16#3dce974e#;
   pragma Export (C, u00135, "system__linuxS");
   u00136 : constant Version_32 := 16#69418a44#;
   pragma Export (C, u00136, "system__os_constantsS");
   u00137 : constant Version_32 := 16#35461298#;
   pragma Export (C, u00137, "system__task_primitives__operationsB");
   u00138 : constant Version_32 := 16#28930186#;
   pragma Export (C, u00138, "system__task_primitives__operationsS");
   u00139 : constant Version_32 := 16#66645a25#;
   pragma Export (C, u00139, "system__interrupt_managementB");
   u00140 : constant Version_32 := 16#f8b85fd3#;
   pragma Export (C, u00140, "system__interrupt_managementS");
   u00141 : constant Version_32 := 16#f65595cf#;
   pragma Export (C, u00141, "system__multiprocessorsB");
   u00142 : constant Version_32 := 16#7e997377#;
   pragma Export (C, u00142, "system__multiprocessorsS");
   u00143 : constant Version_32 := 16#d083f760#;
   pragma Export (C, u00143, "system__os_primitivesB");
   u00144 : constant Version_32 := 16#ccbafd72#;
   pragma Export (C, u00144, "system__os_primitivesS");
   u00145 : constant Version_32 := 16#375a3ef7#;
   pragma Export (C, u00145, "system__task_infoB");
   u00146 : constant Version_32 := 16#c01cd21c#;
   pragma Export (C, u00146, "system__task_infoS");
   u00147 : constant Version_32 := 16#e737d8df#;
   pragma Export (C, u00147, "system__tasking__debugB");
   u00148 : constant Version_32 := 16#72bfd9bc#;
   pragma Export (C, u00148, "system__tasking__debugS");
   u00149 : constant Version_32 := 16#18e0e51c#;
   pragma Export (C, u00149, "system__img_enum_newB");
   u00150 : constant Version_32 := 16#2779eac4#;
   pragma Export (C, u00150, "system__img_enum_newS");
   u00151 : constant Version_32 := 16#9dca6636#;
   pragma Export (C, u00151, "system__img_lliB");
   u00152 : constant Version_32 := 16#577ab9d5#;
   pragma Export (C, u00152, "system__img_lliS");
   u00153 : constant Version_32 := 16#118e865d#;
   pragma Export (C, u00153, "system__stack_usageB");
   u00154 : constant Version_32 := 16#3a3ac346#;
   pragma Export (C, u00154, "system__stack_usageS");
   u00155 : constant Version_32 := 16#772f46f9#;
   pragma Export (C, u00155, "system__tasking__protected_objectsB");
   u00156 : constant Version_32 := 16#a9001c61#;
   pragma Export (C, u00156, "system__tasking__protected_objectsS");
   u00157 : constant Version_32 := 16#8e0cce20#;
   pragma Export (C, u00157, "system__soft_links__taskingB");
   u00158 : constant Version_32 := 16#5ae92880#;
   pragma Export (C, u00158, "system__soft_links__taskingS");
   u00159 : constant Version_32 := 16#17d21067#;
   pragma Export (C, u00159, "ada__exceptions__is_null_occurrenceB");
   u00160 : constant Version_32 := 16#e1d7566f#;
   pragma Export (C, u00160, "ada__exceptions__is_null_occurrenceS");
   u00161 : constant Version_32 := 16#ee80728a#;
   pragma Export (C, u00161, "system__tracesB");
   u00162 : constant Version_32 := 16#b42884ae#;
   pragma Export (C, u00162, "system__tracesS");
   u00163 : constant Version_32 := 16#e138c053#;
   pragma Export (C, u00163, "system__tasking__protected_objects__operationsB");
   u00164 : constant Version_32 := 16#ba36ad85#;
   pragma Export (C, u00164, "system__tasking__protected_objects__operationsS");
   u00165 : constant Version_32 := 16#100eaf58#;
   pragma Export (C, u00165, "system__restrictionsB");
   u00166 : constant Version_32 := 16#aab42239#;
   pragma Export (C, u00166, "system__restrictionsS");
   u00167 : constant Version_32 := 16#6724d389#;
   pragma Export (C, u00167, "system__tasking__entry_callsB");
   u00168 : constant Version_32 := 16#df420580#;
   pragma Export (C, u00168, "system__tasking__entry_callsS");
   u00169 : constant Version_32 := 16#7adc0f68#;
   pragma Export (C, u00169, "system__tasking__initializationB");
   u00170 : constant Version_32 := 16#efd25374#;
   pragma Export (C, u00170, "system__tasking__initializationS");
   u00171 : constant Version_32 := 16#1b84470b#;
   pragma Export (C, u00171, "system__tasking__task_attributesB");
   u00172 : constant Version_32 := 16#6bc95a13#;
   pragma Export (C, u00172, "system__tasking__task_attributesS");
   u00173 : constant Version_32 := 16#eb5ad743#;
   pragma Export (C, u00173, "system__tasking__protected_objects__entriesB");
   u00174 : constant Version_32 := 16#427cf21f#;
   pragma Export (C, u00174, "system__tasking__protected_objects__entriesS");
   u00175 : constant Version_32 := 16#57df25b5#;
   pragma Export (C, u00175, "system__tasking__queuingB");
   u00176 : constant Version_32 := 16#d1ba2fcb#;
   pragma Export (C, u00176, "system__tasking__queuingS");
   u00177 : constant Version_32 := 16#05f5974e#;
   pragma Export (C, u00177, "system__tasking__utilitiesB");
   u00178 : constant Version_32 := 16#9b15eab5#;
   pragma Export (C, u00178, "system__tasking__utilitiesS");
   u00179 : constant Version_32 := 16#bd6fc52e#;
   pragma Export (C, u00179, "system__traces__taskingB");
   u00180 : constant Version_32 := 16#09f07b39#;
   pragma Export (C, u00180, "system__traces__taskingS");
   u00181 : constant Version_32 := 16#ffdce1e2#;
   pragma Export (C, u00181, "system__tasking__rendezvousB");
   u00182 : constant Version_32 := 16#ea18a31e#;
   pragma Export (C, u00182, "system__tasking__rendezvousS");
   u00183 : constant Version_32 := 16#abbae291#;
   pragma Export (C, u00183, "system__tasking__stagesB");
   u00184 : constant Version_32 := 16#a2ee1060#;
   pragma Export (C, u00184, "system__tasking__stagesS");
   u00185 : constant Version_32 := 16#ff0c338a#;
   pragma Export (C, u00185, "ada__real_timeB");
   u00186 : constant Version_32 := 16#c3d451b0#;
   pragma Export (C, u00186, "ada__real_timeS");
   u00187 : constant Version_32 := 16#f0b39030#;
   pragma Export (C, u00187, "tokensB");
   u00188 : constant Version_32 := 16#ec3f2deb#;
   pragma Export (C, u00188, "tokensS");
   u00189 : constant Version_32 := 16#1405386b#;
   pragma Export (C, u00189, "liningB");
   u00190 : constant Version_32 := 16#bbc78b82#;
   pragma Export (C, u00190, "liningS");
   u00191 : constant Version_32 := 16#51511527#;
   pragma Export (C, u00191, "mappingB");
   u00192 : constant Version_32 := 16#d589e3d7#;
   pragma Export (C, u00192, "mappingS");
   u00193 : constant Version_32 := 16#7ac55330#;
   pragma Export (C, u00193, "preprocessingB");
   u00194 : constant Version_32 := 16#c676cbe0#;
   pragma Export (C, u00194, "preprocessingS");
   u00195 : constant Version_32 := 16#0d7f1a43#;
   pragma Export (C, u00195, "ada__calendarB");
   u00196 : constant Version_32 := 16#5b279c75#;
   pragma Export (C, u00196, "ada__calendarS");
   u00197 : constant Version_32 := 16#8f218b8f#;
   pragma Export (C, u00197, "ada__calendar__formattingB");
   u00198 : constant Version_32 := 16#67ade573#;
   pragma Export (C, u00198, "ada__calendar__formattingS");
   u00199 : constant Version_32 := 16#e3cca715#;
   pragma Export (C, u00199, "ada__calendar__time_zonesB");
   u00200 : constant Version_32 := 16#6dc27f8f#;
   pragma Export (C, u00200, "ada__calendar__time_zonesS");
   u00201 : constant Version_32 := 16#d763507a#;
   pragma Export (C, u00201, "system__val_intB");
   u00202 : constant Version_32 := 16#0e90c63b#;
   pragma Export (C, u00202, "system__val_intS");
   u00203 : constant Version_32 := 16#1d9142a4#;
   pragma Export (C, u00203, "system__val_unsB");
   u00204 : constant Version_32 := 16#621b7dbc#;
   pragma Export (C, u00204, "system__val_unsS");
   u00205 : constant Version_32 := 16#faa9a7b2#;
   pragma Export (C, u00205, "system__val_realB");
   u00206 : constant Version_32 := 16#b81c9b15#;
   pragma Export (C, u00206, "system__val_realS");
   u00207 : constant Version_32 := 16#b2a569d2#;
   pragma Export (C, u00207, "system__exn_llfB");
   u00208 : constant Version_32 := 16#fa4b57d8#;
   pragma Export (C, u00208, "system__exn_llfS");
   u00209 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00209, "system__float_controlB");
   u00210 : constant Version_32 := 16#a6c9af38#;
   pragma Export (C, u00210, "system__float_controlS");
   u00211 : constant Version_32 := 16#16458a73#;
   pragma Export (C, u00211, "system__powten_tableS");
   u00212 : constant Version_32 := 16#179d7d28#;
   pragma Export (C, u00212, "ada__containersS");
   u00213 : constant Version_32 := 16#c164a034#;
   pragma Export (C, u00213, "ada__containers__hash_tablesS");
   u00214 : constant Version_32 := 16#bcec81df#;
   pragma Export (C, u00214, "ada__containers__helpersB");
   u00215 : constant Version_32 := 16#4adfc5eb#;
   pragma Export (C, u00215, "ada__containers__helpersS");
   u00216 : constant Version_32 := 16#c24eaf4d#;
   pragma Export (C, u00216, "ada__containers__prime_numbersB");
   u00217 : constant Version_32 := 16#6d3af8ed#;
   pragma Export (C, u00217, "ada__containers__prime_numbersS");
   u00218 : constant Version_32 := 16#8225628b#;
   pragma Export (C, u00218, "ada__containers__red_black_treesS");
   u00219 : constant Version_32 := 16#217daf40#;
   pragma Export (C, u00219, "ada__strings__unbounded__hashB");
   u00220 : constant Version_32 := 16#9c644680#;
   pragma Export (C, u00220, "ada__strings__unbounded__hashS");
   u00221 : constant Version_32 := 16#5a895de2#;
   pragma Export (C, u00221, "system__pool_globalB");
   u00222 : constant Version_32 := 16#7141203e#;
   pragma Export (C, u00222, "system__pool_globalS");
   u00223 : constant Version_32 := 16#a6359005#;
   pragma Export (C, u00223, "system__memoryB");
   u00224 : constant Version_32 := 16#1f488a30#;
   pragma Export (C, u00224, "system__memoryS");
   u00225 : constant Version_32 := 16#7c9380ff#;
   pragma Export (C, u00225, "system__strings__stream_opsB");
   u00226 : constant Version_32 := 16#55d4bd57#;
   pragma Export (C, u00226, "system__strings__stream_opsS");
   u00227 : constant Version_32 := 16#63d47364#;
   pragma Export (C, u00227, "ada__streams__stream_ioB");
   u00228 : constant Version_32 := 16#31fc8e02#;
   pragma Export (C, u00228, "ada__streams__stream_ioS");
   u00229 : constant Version_32 := 16#5de653db#;
   pragma Export (C, u00229, "system__communicationB");
   u00230 : constant Version_32 := 16#5f55b9d6#;
   pragma Export (C, u00230, "system__communicationS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.case_util%s
   --  system.case_util%b
   --  system.exn_llf%s
   --  system.exn_llf%b
   --  system.float_control%s
   --  system.float_control%b
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_enum_new%s
   --  system.img_enum_new%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.img_lli%s
   --  system.img_lli%b
   --  system.io%s
   --  system.io%b
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.powten_table%s
   --  system.restrictions%s
   --  system.restrictions%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.stack_usage%s
   --  system.stack_usage%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.traces%s
   --  system.traces%b
   --  system.unsigned_types%s
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.concat_4%s
   --  system.concat_4%b
   --  system.concat_5%s
   --  system.concat_5%b
   --  system.concat_6%s
   --  system.concat_6%b
   --  system.concat_7%s
   --  system.concat_7%b
   --  system.traceback%s
   --  system.traceback%b
   --  system.wch_stw%s
   --  system.standard_library%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  ada.exceptions%s
   --  system.wch_stw%b
   --  ada.exceptions.traceback%s
   --  system.soft_links%s
   --  system.exception_table%s
   --  system.exception_table%b
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.secondary_stack%s
   --  system.address_image%s
   --  system.soft_links%b
   --  ada.exceptions.last_chance_handler%s
   --  system.memory%s
   --  system.memory%b
   --  ada.exceptions.traceback%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  system.exceptions.machine%s
   --  system.secondary_stack%b
   --  system.address_image%b
   --  ada.exceptions.last_chance_handler%b
   --  system.standard_library%b
   --  ada.exceptions%b
   --  ada.containers%s
   --  ada.containers.prime_numbers%s
   --  ada.containers.prime_numbers%b
   --  ada.exceptions.is_null_occurrence%s
   --  ada.exceptions.is_null_occurrence%b
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.linux%s
   --  system.multiprocessors%s
   --  system.multiprocessors%b
   --  system.os_constants%s
   --  system.os_interface%s
   --  system.os_interface%b
   --  system.os_lib%s
   --  system.os_lib%b
   --  system.task_info%s
   --  system.task_info%b
   --  system.task_primitives%s
   --  system.interrupt_management%s
   --  system.interrupt_management%b
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_llu%s
   --  system.val_llu%b
   --  ada.tags%s
   --  ada.tags%b
   --  ada.streams%s
   --  ada.streams%b
   --  system.communication%s
   --  system.communication%b
   --  system.file_control_block%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  ada.containers.helpers%s
   --  ada.containers.helpers%b
   --  ada.containers.hash_tables%s
   --  ada.containers.red_black_trees%s
   --  system.file_io%s
   --  system.file_io%b
   --  ada.streams.stream_io%s
   --  ada.streams.stream_io%b
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.finalization_masters%b
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools%b
   --  system.storage_pools.subpools.finalization%b
   --  system.stream_attributes%s
   --  system.stream_attributes%b
   --  system.val_real%s
   --  system.val_real%b
   --  system.val_uns%s
   --  system.val_uns%b
   --  system.val_int%s
   --  system.val_int%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.time_zones%s
   --  ada.calendar.time_zones%b
   --  ada.calendar.formatting%s
   --  ada.calendar.formatting%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  ada.strings.unbounded.hash%s
   --  ada.strings.unbounded.hash%b
   --  system.tasking%s
   --  system.task_primitives.operations%s
   --  system.tasking.debug%s
   --  system.tasking%b
   --  system.task_primitives.operations%b
   --  system.tasking.debug%b
   --  system.traces.tasking%s
   --  system.traces.tasking%b
   --  ada.real_time%s
   --  ada.real_time%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.soft_links.tasking%s
   --  system.soft_links.tasking%b
   --  system.strings.stream_ops%s
   --  system.strings.stream_ops%b
   --  system.tasking.initialization%s
   --  system.tasking.task_attributes%s
   --  system.tasking.initialization%b
   --  system.tasking.task_attributes%b
   --  system.tasking.protected_objects%s
   --  system.tasking.protected_objects%b
   --  system.tasking.protected_objects.entries%s
   --  system.tasking.protected_objects.entries%b
   --  system.tasking.queuing%s
   --  system.tasking.queuing%b
   --  system.tasking.utilities%s
   --  system.tasking.utilities%b
   --  system.tasking.entry_calls%s
   --  system.tasking.rendezvous%s
   --  system.tasking.protected_objects.operations%s
   --  system.tasking.protected_objects.operations%b
   --  system.tasking.entry_calls%b
   --  system.tasking.rendezvous%b
   --  system.tasking.stages%s
   --  system.tasking.stages%b
   --  buffers%s
   --  buffers%b
   --  source%s
   --  source%b
   --  mapping%s
   --  mapping%b
   --  lining%s
   --  lining%b
   --  tokens%s
   --  tokens%b
   --  decomposing%s
   --  decomposing%b
   --  preprocessing%s
   --  preprocessing%b
   --  main%b
   --  END ELABORATION ORDER


end ada_main;
