using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using DAL_QuanLyXeBuyt;

namespace BLL_QuanLyXeBuyt
{
    class BLL_Hanh_Khach
    {
        private static BLL_Hanh_Khach instance;

        public static BLL_Hanh_Khach Instance
        {
            get { if (instance == null) instance = new BLL_Hanh_Khach(); return instance; }
            private set { instance = value; }
        }

        private BLL_Hanh_Khach() { }

        public DataTable Xem_Hanh_Khach()
        {
            return Hanh_Khach_DAL.Instance.Xem_Hanh_Khach();
        }
        public DataTable Thong_Ke_Luot_Nguoi(string MATUYEN, string TU_NGAY, string TOI_NGAY)
        {
            return ThongKe_DAL.Instance.Thong_Ke_Luot_Nguoi(MATUYEN, TU_NGAY, TOI_NGAY);
        }
        public bool LoginCheck(string userName, string passWord)
        {
            return Account_DAL.Instance.Login(userName, passWord);
        }
    }
}
