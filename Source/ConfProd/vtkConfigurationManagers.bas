Attribute VB_Name = "vtkConfigurationManagers"
Option Explicit
'---------------------------------------------------------------------------------------
' Module    : vtkConfigurationManagers
' Author    : Jean-Pierre Imbert
' Date      : 25/05/2013
' Purpose   : Manage the configuration managers (class vtkConfigurationManager) for open projects
'
' Usage:
'   - Each instance of Configuration Manager is attached to an Excel Workbook
'       - the method vtkConfigurationManagerForWorkbook give the instance attached to a workbook, or create it
'
'---------------------------------------------------------------------------------------

'   collection of instances indexed by project names
Private configurationManagers As Collection

'---------------------------------------------------------------------------------------
' Procedure : vtkConfigurationManagerForWorkbook
' Author    : Jean-Pierre Imbert
' Date      : 25/05/2013
' Purpose   : Return the configuration manager attached to an Excel file given its name
'               - if the configuration doesn't exist, it is created
'               - if the configurationManagers collection doesn't exist, it is created
'---------------------------------------------------------------------------------------
'
Public Function vtkConfigurationManagerForWorkbook(workbookName As String) As vtkConfigurationManager
    ' Create the collection if it doesn't exist
    If configurationManagers Is Nothing Then
        Set configurationManagers = New Collection
        End If
    ' search for the configuration manager in the collection
    Dim cm As vtkConfigurationManager
    On Error Resume Next
    Set cm = configurationManagers(workbookName)
    If Err <> 0 Then
        Set cm = New vtkConfigurationManager
        cm.workbookName = workbookName
        configurationManagers.Add Item:=cm, Key:=workbookName
        End If
    On Error GoTo 0
    ' return the configuration manager
    Set vtkConfigurationManagerForWorkbook = cm
End Function

'---------------------------------------------------------------------------------------
' Procedure : vtkResetConfigurationManagers
' Author    : Jean-Pierre Imbert
' Date      : 25/05/2013
' Purpose   : Reset all configuration managers (used during tests)
'---------------------------------------------------------------------------------------
'
Public Sub vtkResetConfigurationManagers()
    Set configurationManagers = Nothing
End Sub
