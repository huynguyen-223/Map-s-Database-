using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace DAL_QuanLyXeBuyt
{
    class ThongKe_DAL
    {
        private static ThongKe_DAL instance;

        public static ThongKe_DAL Instance
        {
            get { if (instance == null) instance = new ThongKe_DAL(); return instance; }
            private set { instance = value; }
        }

        private ThongKe_DAL() { }
        
        public DataTable Thong_Ke_Luot_Nguoi(string MATUYEN, string TU_NGAY, string TOI_NGAY)
        {            
            string query = "EXEC ThongKeLuotNguoi '" + MATUYEN + "','" + TU_NGAY + "','" + TOI_NGAY + "'";            
            return DataProvider.Instance.ExecuteQuery(query);
        }
    }
}
