B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Private mreq As ServletRequest 'ignore
	Private mresp As ServletResponse 'ignore
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Try
		mreq = req
		mresp = resp
		If req.ContentType.StartsWith("multipart/form-data") Then
			'parse the multipart data
			Dim parts As Map = req.GetMultipartData(File.DirApp & "/www", 100*1000*1000) ' in bytes
			For i = 0 To parts.Size - 1
				Dim name As String = parts.GetKeyAt(i)
				Dim p As Part = parts.GetValueAt(i)
				Log("Name: " & name)
				If name=("file") Then
					Log(p.TempFile)
					Dim targetDir As String=File.Combine(File.DirApp,"uploaded")
					If File.Exists(targetDir,p.SubmittedFilename)=False Then
						File.Copy(p.TempFile,"",targetDir,p.SubmittedFilename)
						File.Delete(p.TempFile,"")
					Else
						resp.Write("A file with the same already exists.")
						File.Delete(p.TempFile,"")
						Return
					End If
					Dim su As StringUtils
					resp.SendRedirect("/convert2?filename="&su.EncodeUrl(p.SubmittedFilename,"UTF8"))
				End If
			Next
		End If
	Catch
		resp.SendError(500, LastException)
	End Try
End Sub