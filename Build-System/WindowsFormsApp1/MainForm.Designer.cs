namespace WindowsFormsApp1
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btn_Logout = new System.Windows.Forms.Button();
            this.dtgvAdmin = new System.Windows.Forms.DataGridView();
            this.btn_Xem_Hanh_Khach = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.btn_ThemTuyenTauXe = new System.Windows.Forms.Button();
            this.txt_Matuyen = new System.Windows.Forms.TextBox();
            this.txt_Tungay = new System.Windows.Forms.TextBox();
            this.txt_Toingay = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.dtgvAdmin)).BeginInit();
            this.SuspendLayout();
            // 
            // btn_Logout
            // 
            this.btn_Logout.Location = new System.Drawing.Point(537, 12);
            this.btn_Logout.Name = "btn_Logout";
            this.btn_Logout.Size = new System.Drawing.Size(75, 23);
            this.btn_Logout.TabIndex = 7;
            this.btn_Logout.Text = "Logout";
            this.btn_Logout.UseVisualStyleBackColor = true;
            this.btn_Logout.Click += new System.EventHandler(this.btn_Logout_Click);
            // 
            // dtgvAdmin
            // 
            this.dtgvAdmin.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dtgvAdmin.Location = new System.Drawing.Point(12, 91);
            this.dtgvAdmin.Name = "dtgvAdmin";
            this.dtgvAdmin.Size = new System.Drawing.Size(600, 235);
            this.dtgvAdmin.TabIndex = 8;
            // 
            // btn_Xem_Hanh_Khach
            // 
            this.btn_Xem_Hanh_Khach.Location = new System.Drawing.Point(12, 12);
            this.btn_Xem_Hanh_Khach.Name = "btn_Xem_Hanh_Khach";
            this.btn_Xem_Hanh_Khach.Size = new System.Drawing.Size(75, 23);
            this.btn_Xem_Hanh_Khach.TabIndex = 9;
            this.btn_Xem_Hanh_Khach.Text = "Hành Khách";
            this.btn_Xem_Hanh_Khach.UseVisualStyleBackColor = true;
            this.btn_Xem_Hanh_Khach.Click += new System.EventHandler(this.btn_Xem_Hanh_Khach_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(93, 12);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(127, 23);
            this.button1.TabIndex = 10;
            this.button1.Text = "Thống Kê Lượt Người";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // btn_ThemTuyenTauXe
            // 
            this.btn_ThemTuyenTauXe.Location = new System.Drawing.Point(12, 62);
            this.btn_ThemTuyenTauXe.Name = "btn_ThemTuyenTauXe";
            this.btn_ThemTuyenTauXe.Size = new System.Drawing.Size(75, 23);
            this.btn_ThemTuyenTauXe.TabIndex = 11;
            this.btn_ThemTuyenTauXe.Text = "Thêm tuyến tàu xe";
            this.btn_ThemTuyenTauXe.UseVisualStyleBackColor = true;
            this.btn_ThemTuyenTauXe.Click += new System.EventHandler(this.btn_ThemTuyenTauXe_Click);
            // 
            // txt_Matuyen
            // 
            this.txt_Matuyen.Location = new System.Drawing.Point(237, 12);
            this.txt_Matuyen.Name = "txt_Matuyen";
            this.txt_Matuyen.Size = new System.Drawing.Size(100, 20);
            this.txt_Matuyen.TabIndex = 12;
            this.txt_Matuyen.Text = "T001";
            // 
            // txt_Tungay
            // 
            this.txt_Tungay.Location = new System.Drawing.Point(237, 38);
            this.txt_Tungay.Name = "txt_Tungay";
            this.txt_Tungay.Size = new System.Drawing.Size(100, 20);
            this.txt_Tungay.TabIndex = 13;
            this.txt_Tungay.Text = "2021-06-16";
            // 
            // txt_Toingay
            // 
            this.txt_Toingay.Location = new System.Drawing.Point(237, 65);
            this.txt_Toingay.Name = "txt_Toingay";
            this.txt_Toingay.Size = new System.Drawing.Size(100, 20);
            this.txt_Toingay.TabIndex = 14;
            this.txt_Toingay.Text = "2021-06-18";
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(769, 581);
            this.Controls.Add(this.txt_Toingay);
            this.Controls.Add(this.txt_Tungay);
            this.Controls.Add(this.txt_Matuyen);
            this.Controls.Add(this.btn_ThemTuyenTauXe);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.btn_Xem_Hanh_Khach);
            this.Controls.Add(this.dtgvAdmin);
            this.Controls.Add(this.btn_Logout);
            this.Name = "MainForm";
            this.Text = "MainForm";
            ((System.ComponentModel.ISupportInitialize)(this.dtgvAdmin)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btn_Logout;
        private System.Windows.Forms.DataGridView dtgvAdmin;
        private System.Windows.Forms.Button btn_Xem_Hanh_Khach;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button btn_ThemTuyenTauXe;
        private System.Windows.Forms.TextBox txt_Matuyen;
        private System.Windows.Forms.TextBox txt_Tungay;
        private System.Windows.Forms.TextBox txt_Toingay;
    }
}