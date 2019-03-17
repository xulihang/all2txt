B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7
@EndOfDesignText@
'Static code module
Sub Process_Globals

End Sub

Sub getText(filepath As String,outputDir As String) As String
	Dim tikaJO As JavaObject
	tikaJO.InitializeNewInstance("org.apache.tika.Tika",Null)
	Dim content As String
	content=tikaJO.RunMethod("parseToString",Array(getFile(filepath)))
	Log(content)
	File.WriteString(outputDir,File.GetName(filepath)&".txt",content)
	Return content
End Sub

Sub getFile(filepath As String) As JavaObject
	Dim fileJO As JavaObject
	fileJO.InitializeNewInstance("java.io.File",Array As String(filepath))
	Return fileJO
End Sub