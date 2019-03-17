B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
'Handler class
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Try
		resp.CharacterEncoding="UTF-8"
		resp.ContentType = "application/octet-stream"
		'resp.Write("converting...")
		Dim filename As String=req.GetParameter("filename")
		Dim path As String
		Dim uploadedPath As String=File.Combine(File.DirApp,"uploaded")
		Dim convertedPath As String=File.Combine(File.DirApp,"converted")
		path=File.Combine(uploadedPath,filename)
		Dim text As String
		Log(path)
		Log(convertedPath)
		text=tika.getText(path,convertedPath)
		
		If filename.EndsWith(".pdf") Then
			text=Utils.removeLines(text)
		End If
		
		resp.SetHeader("Content-disposition", $"attachment; filename=${filename&".txt"}"$)
		Dim bytes() As Byte
		bytes=text.GetBytes("UTF8")
		resp.OutputStream.WriteBytes(bytes,0,bytes.Length)
	Catch
		resp.SendError(500, LastException)
	End Try
End Sub