Imports System.Data.SqlClient
Imports System.IO
Imports System.Runtime.Serialization.Formatters.Binary
Public Class Artistas_DB
    Dim CN As SqlConnection
    Dim CMD As SqlCommand
    Dim dbServer = "tcp:mednat.ieeta.pt\SQLSERVER,8101"
    Dim dbName = "p3g1"
    Dim username = "p3g1"
    Dim userPass = "TheBest123"
    Dim currentArtist As Integer
    Dim adding As Boolean
    Public Shared Property listaArtistas As New List(Of ArtistasClass)

    Private Sub Artistas_DB_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        CMD = New SqlCommand
        CN = New SqlConnection("data Source= " + dbServer + ";" + "initial Catalog = " + dbName + ";" + "uid = " + username + ";" + "password = " + userPass)
        CMD.Connection = CN
        'por referencia
        CMD.CommandText = " SELECT ID_Artista, Especialidade, Nome, Data_Nascimento, Data_obito FROM ArtGallery.Artista "

        Dim RDR As SqlDataReader
        CN.Open()
        RDR = CMD.ExecuteReader()


        While RDR.Read
            Dim Artistas As New ArtistasClass

            Artistas.Nome = RDR.Item("Nome")
            Artistas.Especialidade = RDR.Item("Especialidade")
            Artistas.idArtista = RDR.Item("ID_Artista")
            Artistas.DataNascimento = RDR.Item("Data_Nascimento")
            If IsDBNull(RDR.Item("Data_Obito")) Then
                Artistas.DataObito = Nothing
            Else
                Artistas.DataObito = RDR.Item("Data_Obito")
            End If

            listaArtistas.Add(Artistas)
            ListBox1.Items.Add(Artistas)

        End While


        RDR.Close()
        CN.Close()
    End Sub

    'Private Sub ListBox1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListBox1.SelectedIndexChanged
    '    Dim index = ListBox1.SelectedIndex
    '    Dim P = listaArtistas(index)

    '    TextBox1.Text = P.Nome
    '    TextBox2.Text = P.idArtista
    '    TextBox3.Text = P.DataNascimento
    '    TextBox4.Text = P.Especialidade
    '    TextBox6.Text = P.DataObito




    'End Sub
    Private Sub Label4_Click(sender As Object, e As EventArgs)

    End Sub

    Sub ShowArtist()
        If ListBox1.Items.Count = 0 Or currentArtist < 0 Then Exit Sub
        Dim artist As New ArtistasClass

        artist = CType(ListBox1.Items.Item(currentArtist), ArtistasClass)
        TextBox1.Text = artist.Nome
        TextBox2.Text = artist.idArtista
        TextBox3.Text = artist.DataNascimento
        TextBox4.Text = artist.Especialidade
        TextBox6.Text = artist.DataObito

    End Sub

    Sub ClearFields()
        TextBox1.Text = ""
        TextBox2.Text = ""
        TextBox3.Text = ""
        TextBox4.Text = ""
        TextBox6.Text = ""
    End Sub

    ' Helper routines
    Sub LockControls()
        TextBox1.ReadOnly = True
        TextBox2.ReadOnly = True
        TextBox3.ReadOnly = True
        TextBox6.ReadOnly = True
        TextBox4.ReadOnly = True

    End Sub

    Sub UnlockControls()
        TextBox1.ReadOnly = False
        TextBox2.ReadOnly = False
        TextBox3.ReadOnly = False
        TextBox6.ReadOnly = False
        TextBox4.ReadOnly = False
    End Sub

    Sub ShowButtons()
        LockControls()
        bttnAdd.Visible = True
        bttnDelete.Visible = True
        bttnEdit.Visible = True
        bttnOK.Visible = False
        bttnCancel.Visible = False
    End Sub

    Sub HideButtons()
        UnlockControls()
        bttnAdd.Visible = False
        bttnDelete.Visible = False
        bttnEdit.Visible = False
        bttnOK.Visible = True
        bttnCancel.Visible = True
    End Sub



    Private Function SaveArtist() As Boolean
        Dim artist As New ArtistasClass

        Try
            artist.Nome = TextBox1.Text
            artist.idArtista = TextBox2.Text
            artist.DataNascimento = TextBox3.Text
            artist.Especialidade = TextBox4.Text
            artist.DataNascimento = TextBox6.Text


        Catch ex As Exception
            MessageBox.Show("ERRO!")
            Return False
        End Try
        If adding Then
            SubmitArtist(artist)
            ListBox1.Items.Add(artist)
        Else
            UpdateArtist(artist)
            ListBox1.Items(currentArtist) = artist
        End If
        Return True
    End Function
    Private Sub SubmitArtist(ByVal A As ArtistasClass)
        CMD.CommandText = "INSERT ArtGallery.Artista (ID_Artista, Especialidade, Nome, Data_Nascimento, Data_obito) " &
                          "VALUES (@ID_Artista, @Nome, @Data_Nascimento, @Data_obito"
        CMD.Parameters.Clear()
        CMD.Parameters.AddWithValue("@ID_Artista", A.idArtista)
        CMD.Parameters.AddWithValue("@Especialidade", A.Especialidade)
        CMD.Parameters.AddWithValue("@Nome", A.Nome)
        CMD.Parameters.AddWithValue("@Data_Nascimento", A.DataNascimento)
        CMD.Parameters.AddWithValue("@Data_obito", A.DataObito)

        CN.Open()
        Try
            CMD.ExecuteNonQuery()
        Catch ex As Exception
            Throw New Exception("Failed to update artist in database. " & vbCrLf & "ERROR MESSAGE: " & vbCrLf & ex.Message)
        Finally
            CN.Close()
        End Try
        CN.Close()
    End Sub
    Private Sub UpdateArtist(ByVal A As ArtistasClass)
        CMD.CommandText = "UPDATE ArtGallery.Artista " &
            "SET ID_Artista = @ID_Artist, " &
            "    Especialidade = @Especialidade, " &
            "    Nome = @Nome " &
            "    Data_Nascimento = @Data_Nascimento, " &
            "    Data_obito = @Data_obito, " &
            "WHERE ID_Artista = @ID_Artista"
        CMD.Parameters.Clear()
        CMD.Parameters.AddWithValue("@ID_Artist", A.idArtista)
        CMD.Parameters.AddWithValue("@Nome", A.Nome)
        CMD.Parameters.AddWithValue("@Especialidade", A.Especialidade)
        CMD.Parameters.AddWithValue("@Data_Nascimento", A.DataNascimento)
        CMD.Parameters.AddWithValue("@Data_obito", A.DataObito)

        CN.Open()
        'Try
        CMD.ExecuteNonQuery()
        'Catch ex As Exception
        '    Throw New Exception("Failed to update contact in database. " & vbCrLf & "ERROR MESSAGE: " & vbCrLf & ex.Message)
        'Finally
        '    CN.Close()
        'End Try
    End Sub

    Private Sub ListBox1_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        ' não funciona  HELP
        Dim index = ListBox1.SelectedIndex
        Dim P = listaArtistas(index)

        TextBox1.Text = P.Nome
        TextBox2.Text = P.idArtista
        TextBox3.Text = P.DataNascimento
        TextBox4.Text = P.Especialidade
        TextBox6.Text = P.DataObito

        'If ListBox1.SelectedIndex > -1 Then
        '    currentArtist = ListBox1.SelectedIndex
        '    ShowArtist()
        'End If
    End Sub

    Sub LoadArtist()
        CMD.CommandText = "SELECT * FROM ArtGallery.Artista"
        CN.Open()
        Dim RDR As SqlDataReader
        RDR = CMD.ExecuteReader
        ListBox1.Items.Clear()
        While RDR.Read
            Dim A As New ArtistasClass
            A.Nome = RDR.Item("Name")
            A.Especialidade = RDR.Item("Especialidade")
            A.DataNascimento = RDR.Item("Data_Nascimento")
            A.DataObito = RDR.Item("Data_obito")

            ListBox1.Items.Add(A)
        End While
        CN.Close()
        currentArtist = 0
        ShowArtist()

    End Sub

    Private Sub bttnAdd_Click_1(sender As Object, e As EventArgs) Handles bttnAdd.Click
        adding = True
        ClearFields()
        HideButtons()
        ListBox1.Enabled = False
    End Sub

    Private Sub bttnOK_Click_1(sender As Object, e As EventArgs) Handles bttnOK.Click
        Try
            SaveArtist()
        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try

        ListBox1.Enabled = True
        Dim idx As Integer = ListBox1.FindString(TextBox2.Text)
        ListBox1.SelectedIndex = idx
        ShowButtons()
    End Sub

    Private Sub bttnDelete_Click_1(sender As Object, e As EventArgs) Handles bttnDelete.Click
        If ListBox1.SelectedIndex > -1 Then
            'RemoveContact(CType(ListBox1.SelectedItem, ArtistasClass).CustomerID)
            ListBox1.Items.RemoveAt(ListBox1.SelectedIndex)
            If currentArtist = ListBox1.Items.Count Then currentArtist = ListBox1.Items.Count - 1
            If currentArtist = -1 Then
                ClearFields()
                MessageBox.Show("There are no more contacts")

            Else
                ShowArtist()
            End If
        End If
    End Sub

    Private Sub BttnEdit_Click_1(sender As Object, e As EventArgs) Handles BttnEdit.Click
        currentArtist = ListBox1.SelectedIndex
        If currentArtist < 0 Then
            MessageBox.Show("Please select a Artist to edit")
            Exit Sub
        End If
        adding = False
        HideButtons()
        ListBox1.Enabled = False
    End Sub

    Private Sub bttnCancel_Click(sender As Object, e As EventArgs) Handles bttnCancel.Click
        ListBox1.Enabled = True
        If ListBox1.Items.Count > 0 Then
            currentArtist = ListBox1.SelectedIndex
            If currentArtist < 0 Then currentArtist = 0
            ShowArtist()
        Else
            ClearFields()
            LockControls()
        End If
        ShowButtons()
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim Secretaria_back = New Secretaria
        Secretaria_back.Show()
        Me.Hide()
    End Sub

    Private Sub ListBox1_SelectedIndexChanged_1(sender As Object, e As EventArgs) Handles ListBox1.SelectedIndexChanged
        Dim index = ListBox1.SelectedIndex
        Dim P = listaArtistas(index)

        TextBox1.Text = P.Nome
        TextBox2.Text = P.idArtista
        TextBox3.Text = P.DataNascimento
        TextBox4.Text = P.Especialidade
        TextBox6.Text = P.DataObito

    End Sub
End Class




