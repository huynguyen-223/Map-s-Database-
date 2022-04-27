using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BLL_QuanLyXeBuyt;

namespace WindowsFormsApp1
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void btn_Login_Click(object sender, EventArgs e)
        {
            string userName = txt_Username.Text;
            string passWord = txt_Password.Text;
            if (BLL_Hanh_Khach.Instance.LoginCheck(userName, passWord))
            {
                MainForm f = new MainForm();
                this.Hide();
                f.ShowDialog();
                this.Show();                
            }
            else
            {
                MessageBox.Show("Sai tên tài khoản hoặc mật khẩu!");
            }
        }

       
    }
}
