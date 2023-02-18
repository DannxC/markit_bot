
namespace Markit
{
    partial class Form_Markit
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            this.labelStatusProcesso = new System.Windows.Forms.Label();
            this.labelStatus = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.textTemporizador = new System.Windows.Forms.TextBox();
            this.textProxExec = new System.Windows.Forms.TextBox();
            this.textExecs = new System.Windows.Forms.TextBox();
            this.textHoraInicio = new System.Windows.Forms.TextBox();
            this.textHoraFim = new System.Windows.Forms.TextBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.buttonIniciar = new System.Windows.Forms.Button();
            this.timerGatilho = new System.Windows.Forms.Timer(this.components);
            this.dataGrid = new System.Windows.Forms.DataGridView();
            this.Arquivo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Num_lins = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.columnUtilExe = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.columnTempo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.textLog = new System.Windows.Forms.TextBox();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGrid)).BeginInit();
            this.SuspendLayout();
            // 
            // labelStatusProcesso
            // 
            this.labelStatusProcesso.AutoSize = true;
            this.labelStatusProcesso.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.labelStatusProcesso.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.labelStatusProcesso.ForeColor = System.Drawing.SystemColors.WindowText;
            this.labelStatusProcesso.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.labelStatusProcesso.Location = new System.Drawing.Point(12, 9);
            this.labelStatusProcesso.Name = "labelStatusProcesso";
            this.labelStatusProcesso.Size = new System.Drawing.Size(114, 15);
            this.labelStatusProcesso.TabIndex = 11;
            this.labelStatusProcesso.Text = "Status Processo:";
            // 
            // labelStatus
            // 
            this.labelStatus.AutoSize = true;
            this.labelStatus.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.labelStatus.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.labelStatus.ForeColor = System.Drawing.Color.Red;
            this.labelStatus.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.labelStatus.Location = new System.Drawing.Point(132, 9);
            this.labelStatus.Name = "labelStatus";
            this.labelStatus.Size = new System.Drawing.Size(53, 15);
            this.labelStatus.TabIndex = 12;
            this.labelStatus.Text = "Parado";
            this.labelStatus.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.BackColor = System.Drawing.SystemColors.Control;
            this.label3.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label3.ForeColor = System.Drawing.SystemColors.WindowText;
            this.label3.Location = new System.Drawing.Point(18, 11);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(85, 13);
            this.label3.TabIndex = 5;
            this.label3.Text = "Temporizador (s)";
            this.label3.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.BackColor = System.Drawing.SystemColors.Control;
            this.label4.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label4.ForeColor = System.Drawing.SystemColors.WindowText;
            this.label4.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.label4.Location = new System.Drawing.Point(18, 68);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(95, 13);
            this.label4.TabIndex = 6;
            this.label4.Text = "Próxima Execução";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.BackColor = System.Drawing.SystemColors.Control;
            this.label5.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label5.ForeColor = System.Drawing.SystemColors.WindowText;
            this.label5.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.label5.Location = new System.Drawing.Point(18, 122);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(60, 13);
            this.label5.TabIndex = 10;
            this.label5.Text = "Execuções";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.BackColor = System.Drawing.SystemColors.Control;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label6.ForeColor = System.Drawing.SystemColors.WindowText;
            this.label6.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.label6.Location = new System.Drawing.Point(18, 176);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(60, 13);
            this.label6.TabIndex = 9;
            this.label6.Text = "Hora Início";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.BackColor = System.Drawing.SystemColors.Control;
            this.label7.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label7.ForeColor = System.Drawing.SystemColors.WindowText;
            this.label7.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.label7.Location = new System.Drawing.Point(141, 176);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(49, 13);
            this.label7.TabIndex = 12;
            this.label7.Text = "Hora Fim";
            // 
            // textTemporizador
            // 
            this.textTemporizador.Location = new System.Drawing.Point(18, 29);
            this.textTemporizador.Name = "textTemporizador";
            this.textTemporizador.Size = new System.Drawing.Size(100, 23);
            this.textTemporizador.TabIndex = 5;
            this.textTemporizador.Text = "60";
            // 
            // textProxExec
            // 
            this.textProxExec.BackColor = System.Drawing.SystemColors.Control;
            this.textProxExec.Enabled = false;
            this.textProxExec.Location = new System.Drawing.Point(18, 86);
            this.textProxExec.Name = "textProxExec";
            this.textProxExec.Size = new System.Drawing.Size(100, 23);
            this.textProxExec.TabIndex = 5;
            // 
            // textExecs
            // 
            this.textExecs.BackColor = System.Drawing.SystemColors.Control;
            this.textExecs.Enabled = false;
            this.textExecs.Location = new System.Drawing.Point(18, 140);
            this.textExecs.Name = "textExecs";
            this.textExecs.Size = new System.Drawing.Size(100, 23);
            this.textExecs.TabIndex = 8;
            this.textExecs.Text = "0";
            // 
            // textHoraInicio
            // 
            this.textHoraInicio.Location = new System.Drawing.Point(18, 194);
            this.textHoraInicio.Name = "textHoraInicio";
            this.textHoraInicio.Size = new System.Drawing.Size(100, 23);
            this.textHoraInicio.TabIndex = 11;
            this.textHoraInicio.Text = "09:00";
            // 
            // textHoraFim
            // 
            this.textHoraFim.Location = new System.Drawing.Point(141, 194);
            this.textHoraFim.Name = "textHoraFim";
            this.textHoraFim.Size = new System.Drawing.Size(100, 23);
            this.textHoraFim.TabIndex = 13;
            this.textHoraFim.Text = "19:00";
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.SystemColors.Control;
            this.panel1.Controls.Add(this.buttonIniciar);
            this.panel1.Controls.Add(this.textHoraFim);
            this.panel1.Controls.Add(this.textHoraInicio);
            this.panel1.Controls.Add(this.textExecs);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.textProxExec);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.textTemporizador);
            this.panel1.Controls.Add(this.label5);
            this.panel1.Controls.Add(this.label7);
            this.panel1.Controls.Add(this.label6);
            this.panel1.Location = new System.Drawing.Point(12, 33);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(253, 229);
            this.panel1.TabIndex = 13;
            // 
            // buttonIniciar
            // 
            this.buttonIniciar.BackColor = System.Drawing.SystemColors.Control;
            this.buttonIniciar.Location = new System.Drawing.Point(141, 28);
            this.buttonIniciar.Name = "buttonIniciar";
            this.buttonIniciar.Size = new System.Drawing.Size(100, 23);
            this.buttonIniciar.TabIndex = 0;
            this.buttonIniciar.Text = "Iniciar";
            this.buttonIniciar.UseVisualStyleBackColor = false;
            this.buttonIniciar.Click += new System.EventHandler(this.buttonIniciar_Click);
            // 
            // timerGatilho
            // 
            this.timerGatilho.Interval = 1000;
            this.timerGatilho.Tick += new System.EventHandler(this.timerGatilho_Tick);
            // 
            // dataGrid
            // 
            this.dataGrid.AllowUserToAddRows = false;
            this.dataGrid.AllowUserToDeleteRows = false;
            this.dataGrid.AllowUserToResizeColumns = false;
            this.dataGrid.AllowUserToResizeRows = false;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.Transparent;
            this.dataGrid.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.dataGrid.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dataGrid.BackgroundColor = System.Drawing.SystemColors.AppWorkspace;
            this.dataGrid.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.dataGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGrid.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Arquivo,
            this.Num_lins,
            this.columnUtilExe,
            this.columnTempo});
            this.dataGrid.Location = new System.Drawing.Point(271, 33);
            this.dataGrid.Name = "dataGrid";
            this.dataGrid.RowHeadersVisible = false;
            this.dataGrid.RowHeadersWidth = 62;
            this.dataGrid.RowTemplate.Height = 25;
            this.dataGrid.Size = new System.Drawing.Size(391, 229);
            this.dataGrid.TabIndex = 9;
            // 
            // Arquivo
            // 
            this.Arquivo.HeaderText = "Arquivo";
            this.Arquivo.MinimumWidth = 8;
            this.Arquivo.Name = "Arquivo";
            this.Arquivo.Width = 70;
            // 
            // Num_lins
            // 
            this.Num_lins.HeaderText = "Qtd_Lin";
            this.Num_lins.Name = "Num_lins";
            this.Num_lins.Width = 60;
            // 
            // columnUtilExe
            // 
            this.columnUtilExe.HeaderText = "Util_Exe";
            this.columnUtilExe.MinimumWidth = 8;
            this.columnUtilExe.Name = "columnUtilExe";
            this.columnUtilExe.Width = 140;
            // 
            // columnTempo
            // 
            this.columnTempo.HeaderText = "Tempo (s)";
            this.columnTempo.MinimumWidth = 8;
            this.columnTempo.Name = "columnTempo";
            this.columnTempo.Width = 120;
            // 
            // textLog
            // 
            this.textLog.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.textLog.Location = new System.Drawing.Point(12, 268);
            this.textLog.Multiline = true;
            this.textLog.Name = "textLog";
            this.textLog.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.textLog.Size = new System.Drawing.Size(650, 193);
            this.textLog.TabIndex = 15;
            // 
            // Form_Markit
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(674, 473);
            this.Controls.Add(this.textLog);
            this.Controls.Add(this.dataGrid);
            this.Controls.Add(this.labelStatusProcesso);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.labelStatus);
            this.Name = "Form_Markit";
            this.Text = "Form_Markit";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGrid)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labelStatusProcesso;
        private System.Windows.Forms.Label labelStatus;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox textTemporizador;
        private System.Windows.Forms.TextBox textProxExec;
        private System.Windows.Forms.TextBox textExecs;
        private System.Windows.Forms.TextBox textHoraInicio;
        private System.Windows.Forms.TextBox textHoraFim;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button buttonIniciar;
        internal System.Windows.Forms.Timer timerGatilho;
        private System.Windows.Forms.DataGridView dataGrid;
        private System.Windows.Forms.TextBox textLog;
        private System.Windows.Forms.Timer timerHoraAtual;
        private System.Windows.Forms.DataGridViewTextBoxColumn Arquivo;
        private System.Windows.Forms.DataGridViewTextBoxColumn Num_lins;
        private System.Windows.Forms.DataGridViewTextBoxColumn columnUtilExe;
        private System.Windows.Forms.DataGridViewTextBoxColumn columnTempo;
    }
}

