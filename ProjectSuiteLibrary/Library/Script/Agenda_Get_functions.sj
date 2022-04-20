//USEUNIT Global_variables
//USEUNIT Common_Get_functions


//WIN AGENDA

function Get_WinAgenda(){return Aliases.CroesusApp.WinAgenda}



//WIN AGENDA PAD HEADER

function Get_WinAgenda_PadHeaderBar(){return Get_WinAgenda().FindChild("Uid", "ItemsControl_ca1a", 10)} //ok

//For Schedule and Tasks tabs
function Get_WinAgenda_PadHeaderBar_LblSearchDescription()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "Text"], ["UniLabel", "Recherche sur la description:"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "Text"], ["UniLabel", "Search Description:"], 10)}
}

//For Schedule tab
function Get_WinAgenda_PadHeaderBar_TxtSearchDescriptionForScheduleTab(){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}

//For Tasks tab
function Get_WinAgenda_PadHeaderBar_TxtSearchDescriptionForTasksTab(){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}

//For Schedule and Tasks tabs
function Get_WinAgenda_PadHeaderBar_BtnPrevious()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Précédent"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Previous"], 10)}
}

//For Schedule and Tasks tabs
function Get_WinAgenda_PadHeaderBar_BtnNext()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Suivant"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Next"], 10)}
}

//For Schedule, Tasks and Birthdays tabs
function Get_WinAgenda_PadHeaderBar_BtnDetailedInfo()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Info détaillée"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Detailed Info"], 10)}
}

//For all tabs
function Get_WinAgenda_PadHeaderBar_BtnPrint()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Imprimer"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Print"], 10)}
}

//For all tabs
function Get_WinAgenda_PadHeaderBar_BtnRedisplayAllRecords()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Réafficher tous les enregistrements"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Redisplay All Records"], 10)} //YR:Corrigé suite à CROES-1693 
}

//For Overdue tab
function Get_WinAgenda_PadHeaderBar_LblOverdueEvents()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "Text"], ["UniLabel", "Activités échues:"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "Text"], ["UniLabel", "Overdue Events:"], 10)}
}

//For Overdue tab
function Get_WinAgenda_PadHeaderBar_CmbOverdueEvents(){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

//For Overdue tab
function Get_WinAgenda_PadHeaderBar_BtnComplete()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Terminer"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Complete"], 10)}
}

//For Overdue tab
function Get_WinAgenda_PadHeaderBar_BtnReschedule()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Rep_orter"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Reschedule"], 10)}
}

//For Overdue tab
function Get_WinAgenda_PadHeaderBar_BtnCancel()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "A_nnuler"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Ca_ncel"], 10)}
}

//For Overdue tab
function Get_WinAgenda_PadHeaderBar_BtnDelete()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"], 10)}
}

//For Alarms tab
function Get_WinAgenda_PadHeaderBar_BtnMark()
{
  if (language=="french"){return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Marquer"], 10)}
  else {return Get_WinAgenda_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Mark"], 10)}
}



//WIN AGENDA BAR BUTTONBAR

function Get_WinAgenda_ButtonBar(){return Get_WinAgenda().FindChild("Uid", "NotebookButtonBar_cd20", 10)} //ok

function Get_WinAgenda_ButtonBar_BtnSchedule() //no uid
{
  if (language=="french"){return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Horaire"], 10)}
  else {return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Schedule"], 10)}
}

function Get_WinAgenda_ButtonBar_BtnTasks() //no uid
{
  if (language=="french"){return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Tâches"], 10)}
  else {return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Tasks"], 10)}
}

function Get_WinAgenda_ButtonBar_BtnOverdue() //no uid
{
  if (language=="french"){return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Activités échues"], 10)}
  else {return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Overdue"], 10)}
}

function Get_WinAgenda_ButtonBar_BtnBirthdays() //no uid
{
  if (language=="french"){return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Anniversaires"], 10)}
  else {return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Birthdays"], 10)}
}

function Get_WinAgenda_ButtonBar_BtnAlarms() //no uid
{
  if (language=="french"){return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Alarmes"], 10)}
  else {return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Alarms"], 10)}
}

function Get_WinAgenda_ButtonBar_BtnFilesProcessing() //no uid
{
  if (language=="french"){return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Traitements"], 10)}
  else {return Get_WinAgenda_ButtonBar().FindChild(["ClrClassName", "Text"], ["NotebookButton", "Files Processing"], 10)}
}



//WIN AGENDA BTNS OK, CANCEL, APPLY

function Get_WinAgenda_BtnOk(){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)} //no uid

function Get_WinAgenda_BtnCancel() //no uid
{
  if (language=="french"){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinAgenda_BtnApply() //no uid
{
  if (language=="french"){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Appliquer"], 10)}
  else {return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Apply"], 10)}
}



//WIN AGENDA : BNTS SETUP, REPORT, SYNCHRONIZE, COMBOBOX USER

function Get_WinAgenda_LblUser() //ok
{
  if (language=="french"){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Utilisateur:"], 10)}
  else {return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["Label", "User:"], 10)}
}

function Get_WinAgenda_CmbUser(){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinAgenda_BtnConfigure() //no uid
{
  if (language=="french"){return Get_WinAgenda().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Configuration"], 10)}
  else {return Get_WinAgenda().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Setup"], 10)}
}

function Get_WinAgenda_BtnConfigure_LblConfigure(){return Get_WinAgenda_BtnConfigure().FindChild("ClrClassName", "AccessText", 10)}

function Get_WinAgenda_BtnReport() //no uid
{
  if (language=="french"){return Get_WinAgenda().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Rapport..."], 10)}
  else {return Get_WinAgenda().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Report..."], 10)}
}

function Get_WinAgenda_BtnReport_LblReport(){return Get_WinAgenda_BtnReport().FindChild("ClrClassName", "AccessText", 10)}

function Get_WinAgenda_BtnSynchronize() //missing in Automation 8
{
  if (language=="french"){return Get_WinAgenda().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Synchroniser..."], 10)}
  else {return Get_WinAgenda().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Synchronize..."], 10)}
}

function Get_WinAgenda_BtnSynchronize_LblSynchronize(){return Get_WinAgenda_BtnSynchronize().FindChild("ClrClassName", "AccessText", 10)}



//WIN AGENDA : SCHEDULE TAB (ONGLET HORAIRE)

function Get_WinAgenda_TabSchedule_GrpCalendar(){return Get_WinAgenda().FindChild("Uid", "GroupBox_d4de", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpCalendar_MonthCalendar(){return Get_WinAgenda_TabSchedule_GrpCalendar().FindChild("Uid", "MonthCalendar_7373", 10)}


function Get_WinAgenda_TabSchedule_ChTime()
{
  if (language=="french"){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Heure"], 10)}
  else {return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Time"], 10)}
}

function Get_WinAgenda_TabSchedule_ChDuration()
{
  if (language=="french"){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Durée"], 10)}
  else {return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Duration"], 10)}
}

function Get_WinAgenda_TabSchedule_ChType(){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Type"], 10)} //no uid

function Get_WinAgenda_TabSchedule_ChClient(){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Client"], 10)} //no uid

function Get_WinAgenda_TabSchedule_ChDescription(){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Description"], 10)} //no uid


function Get_WinAgenda_TabSchedule_GrpInformation(){return Get_WinAgenda().FindChild("Uid", "GroupBox_82f6", 10)}//ok


function Get_WinAgenda_TabSchedule_GrpInformation_LblType(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_b142", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtType(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_73d7", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_LblStatus(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_372c", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtStatus(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_46a3", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_LblFrequency(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_9847", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtFrequency(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_239b", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_LblDate(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_c30a", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtDate(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_2f62", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_LblTime(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_0c06", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtTime(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_5711", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_LblDuration(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_6de5", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtDuration(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_59e0", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_LblPriority(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_841d", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtPriority(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_a984", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_LblReminder(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_22de", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtReminder(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_d7f8", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_LblLastUpdate(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_c86c", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtLastUpdate(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_7274", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_LblClient(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_d32b", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtClient(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_17d5", 10)} //ok 

function Get_WinAgenda_TabSchedule_GrpInformation_LblAccountNo(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_284d", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtAccountNo(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_61f1", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_LblAssignee(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_9e40", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtAssignee(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_c5de", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_LblDescription(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Label_5af5", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_TxtDescription(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "TextBox_26b3", 10)} //ok


function Get_WinAgenda_TabSchedule_GrpInformation_BtnAdd(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Button_7f1b", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_BtnEdit(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Button_a95d", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_BtnDelete(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Button_f83f", 10)} //ok

function Get_WinAgenda_TabSchedule_GrpInformation_BtnCompleted(){return Get_WinAgenda_TabSchedule_GrpInformation().FindChild("Uid", "Button_81d7", 10)} //ok



//WIN AGENDA : TASKS TAB (ONGLET TÂCHES)

function Get_WinAgenda_TabTasks_GrpCalendar(){return Get_WinAgenda().FindChild("Uid", "GroupBox_209d", 10)}

function Get_WinAgenda_TabTasks_GrpCalendar_MonthCalendar(){return Get_WinAgenda_TabTasks_GrpCalendar().FindChild("Uid", "MonthCalendar_7373", 10)}


function Get_WinAgenda_TabTasks_ChType(){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Type"], 10)}

function Get_WinAgenda_TabTasks_ChClient(){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Client"], 10)}

function Get_WinAgenda_TabTasks_ChDescription(){return Get_WinAgenda().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Description"], 10)}


function Get_WinAgenda_TabTasks_GrpInformation(){return Get_WinAgenda().FindChild("Uid", "GroupBox_84d1", 10)}


function Get_WinAgenda_TabTasks_GrpInformation_LblType(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Label_dc3e", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_TxtType(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "TextBox_3d5f", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_LblStatus(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Label_4a35", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_TxtStatus(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "TextBox_92d9", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_LblFrequency(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Label_38ed", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_TxtFrequency(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "TextBox_0cb9", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_LblDate(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Label_adeb", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_TxtDate(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "TextBox_aa9a", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_LblDuration(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Label_04a4", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_TxtDuration(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "TextBox_b64c", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_LblPriority(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Label_2172", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_TxtPriority(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "TextBox_68eb", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_LblLastUpdate(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Label_9765", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_TxtLastUpdate(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "TextBox_242d", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_LblClient(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Label_f7a0", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_TxtClient(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "TextBox_505b", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_LblAccountNo(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Label_9042", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_TxtAccountNo(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "TextBox_8bcf", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_LblAssignee(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Label_7d41", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_TxtAssignee(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "TextBox_908c", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_LblDescription(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Label_7733", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_TxtDescription(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "TextBox_d06b", 10)}


function Get_WinAgenda_TabTasks_GrpInformation_BtnAdd(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Button_cfa9", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_BtnEdit(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Button_b8da", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_BtnDelete(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Button_8db6", 10)}

function Get_WinAgenda_TabTasks_GrpInformation_BtnCompleted(){return Get_WinAgenda_TabTasks_GrpInformation().FindChild("Uid", "Button_7939", 10)}


//WIN AGENDA : LISTVIEW CONTROL

function Get_WinAgenda_DgvListView(){return Get_WinAgenda().FindChild("Uid", "FixedColumnListView_1b3e", 10)}


//WIN AGENDA : OVERDUE TAB (ONGLET ACTIVITÉS ÉCHUES)

function Get_WinAgenda_TabOverdue_ChDate(){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Date"], 10)}

function Get_WinAgenda_TabOverdue_ChTime()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Heure"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Time"], 10)}
}

function Get_WinAgenda_TabOverdue_ChDuration()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Durée"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Duration"], 10)}
}

function Get_WinAgenda_TabOverdue_ChType(){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Type"], 10)}

function Get_WinAgenda_TabOverdue_ChClient(){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Client"], 10)}

function Get_WinAgenda_TabOverdue_ChClientNo()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "No du client"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Client No."], 10)}
}

function Get_WinAgenda_TabOverdue_ChDescription(){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Description"], 10)}

function Get_WinAgenda_TabOverdue_ChCompletionDate()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Complété"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Completion Date"], 10)}
}

function Get_WinAgenda_TabOverdue_ChCreationDate()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Création"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Creation Date"], 10)}
}

function Get_WinAgenda_TabOverdue_ChUpdateDate()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Date MAJ"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Update Date"], 10)}
}

function Get_WinAgenda_TabOverdue_ChFrequency()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Fréquence"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Frequency"], 10)}
}

function Get_WinAgenda_TabOverdue_ChPriority()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Priorité"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Priority"], 10)}
}

function Get_WinAgenda_TabOverdue_ChStatus()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "État"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Status"], 10)}
}



//WIN AGENDA : BIRTHDAYS TAB (ONGLET ANNIVERSAIRES)

function Get_WinAgenda_TabBirthdays_ChName()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Nom"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Name"], 10)}
}

function Get_WinAgenda_TabBirthdays_ChDateOfBirth()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Date de naissance"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Date of Birth"], 10)}
}

function Get_WinAgenda_TabBirthdays_ChAge(){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Age"], 10)}

function Get_WinAgenda_TabBirthdays_ChLastContact()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Dern. contact"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Last Contact"], 10)}
}

function Get_WinAgenda_TabBirthdays_ChTelephone1()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Téléphone 1"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Telephone 1"], 10)}
}

function Get_WinAgenda_TabBirthdays_ChTelephone2()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Téléphone 2"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Telephone 2"], 10)}
}

function Get_WinAgenda_TabBirthdays_ChTelephone3()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Téléphone 3"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Telephone 3"], 10)}
}

function Get_WinAgenda_TabBirthdays_ChTelephone4()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Téléphone 4"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Telephone 4"], 10)}
}

function Get_WinAgenda_TabBirthdays_ChIACode()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Code de CP"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "IA Code"], 10)}
}

function Get_WinAgenda_TabBirthdays_ChLanguage()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Langue"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Language"], 10)}
}

function Get_WinAgenda_TabBirthdays_ChClientNo()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "No du client"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Client No."], 10)}
}

function Get_WinAgenda_TabBirthdays_ChTotalValue()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Valeur totale"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Total Value"], 10)}
}



//WIN AGENDA : ALARMS TAB (ONGLET ALARMES)

function Get_WinAgenda_TabAlarms_ChName()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Nom"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Name"], 10)}
}

function Get_WinAgenda_TabAlarms_ChUpdate()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Mise à jour"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Update"], 10)}
}

function Get_WinAgenda_TabAlarms_ChDescription(){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Description"], 10)}

function Get_WinAgenda_TabAlarms_ChIACode()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Code de CP"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "IA Code"], 10)}
}

function Get_WinAgenda_TabAlarms_ChExpirationDate()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Date expir."], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Expiration Date"], 10)}
}

function Get_WinAgenda_TabAlarms_ChTime()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Heure"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Time"], 10)}
}

function Get_WinAgenda_TabAlarms_ChAccountNo()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "No de compte"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Account No."], 10)}
}



//WIN AGENDA : FILES PROCESSING TAB (ONGLET TRAITEMENTS)

function Get_WinAgenda_TabFilesProcessing_ChUpdate()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Mise à jour"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Update"], 10)}
}

function Get_WinAgenda_TabFilesProcessing_ChIACode()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Code de CP"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "IA Code"], 10)}
}

function Get_WinAgenda_TabFilesProcessing_ChDescription(){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Description"], 10)}

function Get_WinAgenda_TabFilesProcessing_ChExpirationDate()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Date expir."], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Expiration Date"], 10)}
}

function Get_WinAgenda_TabFilesProcessing_ChTime()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Heure"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Time"], 10)}
}

function Get_WinAgenda_TabFilesProcessing_ChAccountNo()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "No de compte"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Account No."], 10)}
}

function Get_WinAgenda_TabFilesProcessing_ChName()
{
  if (language=="french"){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Nom"], 10)}
  else {return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Name"], 10)}
}

function Get_WinAgenda_TabFilesProcessing_ChUserNum(){return Get_WinAgenda_DgvListView().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "USER_NUM"], 10)} // L’entête est la même dans V8



/************************ Win Add/Edit an Event for Schedule (Fenêtre Ajouter/Modifier un événement pour l'onglet Horaire) **********************/

function Get_WinAddEditAnEvent(){return Aliases.CroesusApp.winInformation}

function Get_WinAddEditAnEvent_BtnOKForSchedule(){return Get_WinAddEditAnEvent().FindChild("Uid", "Button_d381", 10)}

function Get_WinAddEditAnEvent_BtnCancelForSchedule(){return Get_WinAddEditAnEvent().FindChild("Uid", "Button_11f1", 10)}


function Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule(){return Get_WinAddEditAnEvent().FindChild("Uid", "GroupBox_6c0e", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblTypeForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_a01b", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("WPFControlName", "comboType", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblStatusForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_8ab3", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbStatusForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("WPFControlName", "comboStatus", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblFrequencyForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_bf1b", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbFrequencyForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("WPFControlName", "comboFrequency", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDateForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_07f6", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "DateField_5590", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblTimeForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_4a2f", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTimeForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("WPFControlName", "comboTime", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDurationForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_1d87", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbDurationForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("WPFControlName", "comboDuration", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblPriorityForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_491d", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbPriorityForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("WPFControlName", "comboPriority", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblReminderForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_0c7c", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbReminderForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("WPFControlName", "comboReminder", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblLastUpdateForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_425d", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtLastUpdateForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "TextBox_49dc", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblClientForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_af38", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtClientForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnClientForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button", "1"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAccountNoForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_d795", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAccountNoForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAccountNoForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button", "3"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAssigneeForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_7f6b", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAssigneeForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAssigneeForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button", "4"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDescriptionForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "Label_7a82", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtDescriptionForSchedule(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForSchedule().FindChild("Uid", "TextBox_8932", 10)}



/************************ Win Add/Edit an Event for Tasks (Fenêtre Ajouter/Modifier un événement pour l'onglet Tâches) **********************/

function Get_WinAddEditAnEvent_BtnOKForTasks(){return Get_WinAddEditAnEvent().FindChild("Uid", "Button_5f5c", 10)}

function Get_WinAddEditAnEvent_BtnCancelForTasks(){return Get_WinAddEditAnEvent().FindChild("Uid", "Button_6608", 10)}


function Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks(){return Get_WinAddEditAnEvent().FindChild("Uid", "GroupBox_c03d", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblTypeForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "Label_dac6", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("WPFControlName", "comboType", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblStatusForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "Label_01c8", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbStatusForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("WPFControlName", "comboStatus", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblFrequencyForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "Label_6e37", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbFrequencyForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("WPFControlName", "comboFrequency", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDateForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "Label_072f", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "DateField_e635", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDurationForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "Label_e1e2", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbDurationForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("WPFControlName", "comboDuration", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblPriorityForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "Label_5bb3", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbPriorityForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("WPFControlName", "comboPriority", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblLastUpdateForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "Label_3d0d", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtLastUpdateForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "TextBox_0f2b", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblClientForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "Label_dddf", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtClientForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnClientForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button", "1"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAccountNoForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "Label_9a15", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAccountNoForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAccountNoForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button", "3"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAssigneeForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "Label_8ff7", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAssigneeForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAssigneeForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button", "4"], 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDescriptionForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "Label_397b", 10)}

function Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtDescriptionForTasks(){return Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks().FindChild("Uid", "TextBox_482f", 10)}



/***************************** Fenêtre de sélection d'un Client (Client selection window) *************************/

function Get_WinClients(){return Aliases.CroesusApp.winClients}

function Get_WinClients_BtnOK(){return Get_WinClients().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinClients_BtnCancel(){return Get_WinClients().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}



/***************************** Fenêtre de sélection d'un Compte (Account selection window) *************************/

function Get_WinAccounts(){return Aliases.CroesusApp.winAccounts}

function Get_WinAccounts_BtnOK(){return Get_WinAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinAccounts_BtnCancel(){return Get_WinAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}



/***************************** Fenêtre de sélection d'un Utilisateur (User selection window) *************************/

function Get_WinUsers(){return Aliases.CroesusApp.winUsers}

function Get_WinUsers_BtnSelectAll(){return Get_WinUsers().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinUsers_BtnReset(){return Get_WinUsers().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}

function Get_WinUsers_BtnOK(){return Get_WinUsers().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "3"], 10)}

function Get_WinUsers_BtnCancel(){return Get_WinUsers().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "4"], 10)}



/*********************** Fenêtre Reporter de l'onglet Activités échues (Rescheduled window of Overdue tab) *******************/

function Get_WinRescheduled(){return Aliases.CroesusApp.winRescheduled}

function Get_WinRescheduled_LblOldDate(){return Get_WinRescheduled().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinRescheduled_TxtOldDate(){return Get_WinRescheduled().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinRescheduled_LblOldTime(){return Get_WinRescheduled().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinRescheduled_TxtOldTime(){return Get_WinRescheduled().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}

function Get_WinRescheduled_LblNewDate(){//Les modifications dues aux changements dans la BD 
   if (client == "RJ"){
      return Get_WinRescheduled().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)
   }
   else{//RJ
      return Get_WinRescheduled().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)
   }
 }

function Get_WinRescheduled_DtpNewDate(){return Get_WinRescheduled().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinRescheduled_LblNewTime(){return Get_WinRescheduled().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinRescheduled_CmbNewTime(){return Get_WinRescheduled().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinRescheduled_BtnOK(){return Get_WinRescheduled().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinRescheduled_BtnCancel(){return Get_WinRescheduled().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}



/******************************** User Selection window - "Work As" window (Fenêtre Slélection Utilisateurs - fenêtre "Travailler en tant que") ***************************/

function Get_WinUserSelection(){return Aliases.CroesusApp.winUserSelection}


function Get_WinUserSelection_LblAvailableUsers(){return Get_WinUserSelection().FindChild("Uid", "TextBlock_2e0f", 10)}

function Get_WinUserSelection_DgvAvailableUsers(){return Get_WinUserSelection().FindChild("Uid", "DataGrid_21cc", 10)}

function Get_WinUserSelection_DgvAvailableUsers_ChLastName()
{
  if (language=="french"){return Get_WinUserSelection_DgvAvailableUsers().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinUserSelection_DgvAvailableUsers().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Name"], 10)}
}

function Get_WinUserSelection_DgvAvailableUsers_ChFirstName()
{
  if (language=="french"){return Get_WinUserSelection_DgvAvailableUsers().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prénom"], 10)}
  else {return Get_WinUserSelection_DgvAvailableUsers().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "First Name"], 10)}
}


function Get_WinUserSelection_BtnAddCurrentAvailableUserToSelectionList(){return Get_WinUserSelection().FindChild("Uid", "Button_aba9", 10)}

function Get_WinUserSelection_BtnRemoveTheSelectedUserFromTheSelectionList(){return Get_WinUserSelection().FindChild("Uid", "Button_50bd", 10)}


function Get_WinUserSelection_LblSelectedUsers(){return Get_WinUserSelection().FindChild("Uid", "TextBlock_179f", 10)}

function Get_WinUserSelection_DgvSelectedUsers(){return Get_WinUserSelection().FindChild("Uid", "DataGrid_bac4", 10)}

function Get_WinUserSelection_DgvSelectedUsers_ChLastName()
{
  if (language=="french"){return Get_WinUserSelection_DgvSelectedUsers().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinUserSelection_DgvSelectedUsers().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Name"], 10)}
}

function Get_WinUserSelection_DgvSelectedUsers_ChFirstName()
{
  if (language=="french"){return Get_WinUserSelection_DgvSelectedUsers().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prénom"], 10)}
  else {return Get_WinUserSelection_DgvSelectedUsers().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "First Name"], 10)}
}


function Get_WinUserSelection_BtnOK(){return Get_WinUserSelection().FindChild("Uid", "Button_664f", 10)}

function Get_WinUserSelection_BtnCancel(){return Get_WinUserSelection().FindChild("Uid", "Button_dfb6", 10)}




//********************* MENU CONTEXTUEL SUR ENTÊTES DE COLONNE DU GRID (CONTEXTUAL MENU ON THE GRID HEADERS) ***************************

function Get_WinAgendaGridHeader_ContextualMenu(){return Get_SubMenus().Find("ClrClassName", "ContextMenu", 10)}

function Get_WinAgendaGridHeader_ContextualMenu_AddColumn()
{
  if (language=="french"){return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Ajouter une colonne"], 10)}
  else {return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Add Column"], 10)}
}

function Get_WinAgendaGridHeader_ContextualMenu_ReplaceColumnWith()
{
  if (language=="french"){return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Remplacer par"], 10)}
  else {return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Replace Column With"], 10)}
}

function Get_WinAgendaGridHeader_ContextualMenu_RemoveThisColumn()
{
  if (language=="french"){return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Enlever cette colonne"], 10)}
  else {return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Remove this Column"], 10)}
}

function Get_WinAgendaGridHeader_ContextualMenu_ColumnStatus()
{
  if (language=="french"){return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "État de la colonne"], 10)}
  else {return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Column Status"], 10)}
}

function Get_WinAgendaGridHeader_ContextualMenu_ConfigureColumns()
{
  if (language=="french"){return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Configurer les colonnes..."], 10)}
  else {return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Configure Columns..."], 10)}
}

function Get_WinAgendaGridHeader_ContextualMenu_InsertField()
{
  if (language=="french"){return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Insérer un champ"], 10)}
  else {return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Insert Field"], 10)}
}

function Get_WinAgendaGridHeader_ContextualMenu_RemoveThisField()
{
  if (language=="french"){return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Enlever ce champ"], 10)}
  else {return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Remove this Field"], 10)}
}

function Get_WinAgendaGridHeader_ContextualMenu_UseDefaultConfiguration()
{
  if (language=="french"){return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Configuration par défaut"], 10)}
  else {return Get_WinAgendaGridHeader_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Use Default Configuration"], 10)}
}



/********************************** FENÊTRE CONFIGURATION DES COLONNES (COLUMN CONFIGURATION WINDOW) ********************************/

function Get_WinColumnConfiguration(){return Aliases.CroesusApp.winColumnConfiguration}

function Get_WinColumnConfiguration_LblAvailableColumns()
{
  if (language=="french"){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Colonnes disponibles"], 10)}
  else {return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Available Columns"], 10)}
}

function Get_WinColumnConfiguration_LvwAvailableColumns(){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"], 10)}

function Get_WinColumnConfiguration_LblSelectedColumns()
{
  if (language=="french"){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Colonnes sélectionnées"], 10)}
  else {return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Selected Columns"], 10)}
}

function Get_WinColumnConfiguration_TvwSelectedColumns(){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeView", "1"], 10)}

function Get_WinColumnConfiguration_LblWidth()
{
  if (language=="french"){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Largeur"], 10)}
  else {return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Width"], 10)}
}

function Get_WinColumnConfiguration_TxtWidth(){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)}

function Get_WinColumnConfiguration_BtnAdd()
{
  if (language=="french"){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Ajouter"], 10)}
  else {return Get_WinColumnConfiguration().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Add"], 10)}
}

function Get_WinColumnConfiguration_BtnRemove()
{
  if (language=="french"){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Enlever"], 10)}
  else {return Get_WinColumnConfiguration().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Remove"], 10)}
}

function Get_WinColumnConfiguration_BtnMoveUp()
{
  if (language=="french"){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Monter"], 10)}
  else {return Get_WinColumnConfiguration().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Move Up"], 10)}
}

function Get_WinColumnConfiguration_BtnMoveDown()
{
  if (language=="french"){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Descendre"], 10)}
  else {return Get_WinColumnConfiguration().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Move Down"], 10)}
}

function Get_WinColumnConfiguration_BtnOK(){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinColumnConfiguration_BtnCancel()
{
  if (language=="french"){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinColumnConfiguration_BtnApply()
{
  if (language=="french"){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Appliquer"], 10)}
  else {return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Apply"], 10)}
}

function Get_WinColumnConfiguration_BtnDefault()
{
  if (language=="french"){return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Défaut"], 10)}
  else {return Get_WinColumnConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Default"], 10)}
}



/********************************** FENÊTRE RAPPEL (REMINDER WINDOW) ********************************/

function Get_WinReminder(){return Aliases.CroesusApp.winReminder}

function Get_WinReminder_BtnOK(){return Get_WinReminder().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinReminder_GrpAction(){return Get_WinReminder().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Action"], 10)}

function Get_WinReminder_GrpAction_ChkDontShowThisReminderAnymore()
{
  if (language=="french"){return Get_WinReminder_GrpAction().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Ne plus afficher ce rappel."], 10)}
  else {return Get_WinReminder_GrpAction().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Don't show this reminder anymore."], 10)}
}
