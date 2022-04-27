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
    public partial class MainForm : Form
    {        
        public MainForm()
        {
            InitializeComponent();
        }

        private void btn_Logout_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btn_Xem_Hanh_Khach_Click(object sender, EventArgs e)
        {
            dtgvAdmin.DataSource = BLL_Hanh_Khach.Instance.Xem_Hanh_Khach();
        }        

        private void button1_Click(object sender, EventArgs e)
        {
            string MATUYEN = txt_Matuyen.Text;
            string TU_NGAY = txt_Tungay.Text;
            string TOI_NGAY = txt_Toingay.Text;
            dtgvAdmin.DataSource = BLL_Hanh_Khach.Instance.Thong_Ke_Luot_Nguoi(MATUYEN,TU_NGAY,TOI_NGAY);
            
        }        

        private void btn_ThemTuyenTauXe_Click(object sender, EventArgs e)
        {

        }
    }   
}
