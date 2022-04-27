using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace DAL_QuanLyXeBuyt
{
    class Hanh_Khach_DAL
    {
        private static Hanh_Khach_DAL instance;

        public static Hanh_Khach_DAL Instance
        {
            get { if (instance == null) instance = new Hanh_Khach_DAL(); return instance; }
            private set { instance = value; }
        }

        private Hanh_Khach_DAL() { }

        public DataTable Xem_Hanh_Khach()
        {            
            string query = "EXEC SELECT_ALL_HANH_KHACH";            
            return DataProvider.Instance.ExecuteQuery(query);
        }
    }
}
