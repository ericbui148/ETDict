//+------------------------------------------------------------------+
//|                                                       ETDict.mqh |
//|                              Copyright 2024, Eric Trader Company |
//|                                           https://erictrader.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Eric Trader Company"
#property link      "https://erictrader.com"
#property version   "1.00"

enum ETDictType
  {
   ET_UNDEF, ET_NULL, ET_BOOL, ET_INT, ET_LONG, ET_DATETIME, ET_DOUBLE, ET_FLOAT, ET_STRING, ET_ARRAY, ET_OBJ
  };

//+------------------------------------------------------------------+
//| ETDict Class                                                     |
//+------------------------------------------------------------------+
class ETDict
  {
protected:
   ETDict            m_e[];
   string            m_key;
   string            m_lkey;
   ETDict            *m_parent;
   ETDictType        m_type;
   bool              m_bv;
   long              m_lv;
   int               m_iv;
   datetime          m_dtv;
   double            m_dv;
   float             m_fv;
   int               m_prec;
   string            m_sv;
   void              Clear(ETDictType jt = ET_UNDEF, bool savekey = false);
public:
   static int        code_page;
                     ETDict();
                     ETDict(ETDict *aparent, ETDictType atype);
                     ETDict(ETDictType t, string a);
                     ETDict(const int a);
                     ETDict(const long a);
                     ETDict(const datetime a);
                     ETDict(const double a, int aprec = -100);
                     ETDict(const float a, int aprec = -100);
                     ETDict(const bool a);
                     ETDict(const ETDict &a);
                    ~ETDict();
   bool              Copy(const ETDict &a);
   void              CopyData(const ETDict &a);
   void              CopyArr(const ETDict &a);
   int               Size();
   bool              IsNumeric();
   ETDict*           FindKey(string akey);
   ETDict*           HasKey(string akey, ETDictType atype = ET_UNDEF);
   ETDict*           operator[](string akey);
   ETDict*           operator[](int i);
   void              operator=(const ETDict &a);
   void              operator=(const int a);
   void              operator=(const long a);
   void              operator=(const datetime a);
   void              operator=(const double a);
   void              operator=(const float a);
   void              operator=(const bool a);
   void              operator=(string a);
   bool              operator==(const int a);
   bool              operator==(const long a);
   bool              operator==(const datetime a);
   bool              operator==(const double a);
   bool              operator==(const float a);
   bool              operator==(const bool a);
   bool              operator==(string a);
   bool              operator!=(const int a);
   bool              operator!=(const long a);
   bool              operator!=(const datetime a);
   bool              operator!=(const double a);
   bool              operator!=(const float a);
   bool              operator!=(const bool a);
   bool              operator!=(string a);
   int               ToInt() const;
   long              ToLong() const;
   datetime          ToDatetime() const;
   double            ToDouble() const;
   double            ToFloat() const;
   bool              ToBool() const;
   string            ToStr();

   void              FromStr(ETDictType t, string a);
   string            GetStr(char &js[], int i, int slen);
   void              Set(const ETDict &a);
   void              Set(const ETDict &list[]);
   ETDict*           Add(const ETDict &item);
   ETDict*           Add(const int a);
   ETDict*           Add(const long a);
   ETDict*           Add(const double a, int aprec = -2);
   ETDict*           Add(const bool a);
   ETDict*           Add(string a);
   ETDict*           AddBase(const ETDict &item);
   ETDict*           New();
   ETDict*           NewBase();
   string            Escape(string a);
   string            Unescape(string a);
   void              Serialize(string &js, bool bf = false, bool bcoma = false);
   string            Serialize();
   bool              Deserialize(char &js[], int slen, int &i);
   bool              ExtrStr(char &js[], int slen, int &i);
   bool              Deserialize(string js, int acp = CP_ACP);
   bool              Deserialize(char &js[], int acp = CP_ACP);
  };

int ETDict::code_page = CP_ACP;

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
ETDict::ETDict()
  {
   Clear();
  }

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
ETDict::ETDict(ETDict *aparent, ETDictType atype)
  {
   Clear();
   m_type = atype;
   m_parent = aparent;
  }

//+------------------------------------------------------------------+
//| Cosntructor                                                      |
//+------------------------------------------------------------------+
ETDict::ETDict(ETDictType t, string a)
  {
   Clear();
   FromStr(t, a);
  }

//+------------------------------------------------------------------+
//|  Constructor                                                     |
//+------------------------------------------------------------------+
ETDict::ETDict(const int a)
  {
   Clear();
   m_type = ET_INT;
   m_iv = a;
   m_lv = (long)m_iv;
   m_dtv = (datetime)m_iv;
   m_dv = (double) m_iv;
   m_fv = (float) m_iv;
   m_sv = IntegerToString(m_iv);
   m_bv = m_iv != 0;
  }

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
ETDict::ETDict(const long a)
  {
   Clear();
   m_type = ET_LONG;
   m_lv = a;
   m_iv = (int)a;
   m_dtv = (datetime)m_iv;
   m_dv = (double)m_iv;
   m_fv = (float)m_iv;
   m_sv = IntegerToString(m_iv);
   m_bv = m_iv != 0;
  }
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
ETDict::ETDict(const datetime a)
  {
   Clear();
   m_type = ET_DATETIME;
   m_dtv = m_iv;
   m_iv = (int)a;
   m_lv = (long)m_iv;
   m_dv = (double)m_iv;
   m_fv = (float)m_iv;
   m_sv = IntegerToString(m_iv);
   m_bv = m_iv != 0;
  }
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
ETDict::ETDict(const double a, int aprec = -100)
  {
   Clear();
   m_type = ET_DOUBLE;
   m_dv = a;
   m_fv = (float)m_dv;
   if(aprec > -100)
      m_prec = aprec;
   m_iv = (int) m_dv;
   m_lv = (long) m_dv;
   m_sv = DoubleToString(m_dv, m_prec);
   m_bv = m_iv != 0;
  }
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
ETDict::ETDict(const float a, int aprec = -100)
  {
   Clear();
   m_type = ET_FLOAT;
   m_fv = a;
   if(aprec > -100)
      m_prec = aprec;
   m_dv = (double)a;
   m_iv = (int)m_dv;
   m_lv = (long)m_dv;
   m_dtv = (datetime)m_dv;
   m_sv = DoubleToString(m_dv, m_prec);
   m_bv = m_iv != 0;
  }

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
ETDict::ETDict(const bool a)
  {
   Clear();
   m_type = ET_BOOL;
   m_bv = a;
   m_iv = m_bv;
   m_lv = (long)m_iv;
   m_dtv = (datetime)m_iv;
   m_dv = m_bv;
   m_sv = IntegerToString(m_iv);
  }

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
ETDict::ETDict(const ETDict &a)
  {
   Clear();
   Copy(a);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
ETDict::~ETDict()
  {
   Clear();
  }

//+------------------------------------------------------------------+
//|  Clear data                                                      |
//+------------------------------------------------------------------+
void ETDict::Clear(ETDictType jt = ET_UNDEF, bool savekey = false)
  {
   m_parent = NULL;
   if(!savekey)
      m_key = "";
   m_type = jt;
   m_bv = false;
   m_iv = 0;
   m_lv = 0;
   m_dtv = 0;
   m_dv = 0;
   m_fv = 0;
   m_prec = 8;
   m_sv = "";
   ArrayResize(m_e, 0, 100);
  }

//+------------------------------------------------------------------+
//| Copy                                                             |
//+------------------------------------------------------------------+
bool ETDict::Copy(const ETDict &a)
  {
   m_key = a.m_key;
   CopyData(a);
   return true;
  }

//+------------------------------------------------------------------+
//| Copy data                                                        |
//+------------------------------------------------------------------+
void ETDict::CopyData(const ETDict &a)
  {
   m_type = a.m_type;
   m_bv = a.m_bv;
   m_iv = a.m_iv;
   m_lv = a.m_lv;
   m_dtv = a.m_dtv;
   m_dv = a.m_dv;
   m_fv = a.m_fv;
   m_prec = a.m_prec;
   m_sv = a.m_sv;
   CopyArr(a);
  }

//+------------------------------------------------------------------+
//| Copy Array                                                       |
//+------------------------------------------------------------------+
void ETDict::CopyArr(const ETDict &a)
  {
   int n = ArrayResize(m_e, ArraySize(a.m_e));
   for(int i = 0; i < n; i++)
     {
      m_e[i] = a.m_e[i];
      m_e[i].m_parent = GetPointer(this);
     }
  }

//+------------------------------------------------------------------+
//| Size                                                             |
//+------------------------------------------------------------------+
int ETDict::Size()
  {
   return ArraySize(m_e);
  }

//+------------------------------------------------------------------+
//| Is Numeric                                                       |
//+------------------------------------------------------------------+
bool ETDict::IsNumeric()
  {
   return m_type == ET_DOUBLE || m_type == ET_FLOAT || m_type == ET_INT || m_type == ET_LONG;
  }

//+------------------------------------------------------------------+
//| Find by key                                                      |
//+------------------------------------------------------------------+
ETDict* ETDict::FindKey(string akey)
  {
   for(int i = Size() - 1; i >= 0; --i)
     {
      if(m_e[i].m_key == akey)
         return GetPointer(m_e[i]);
     }
   return NULL;
  }

//+------------------------------------------------------------------+
//| Has Key                                                          |
//+------------------------------------------------------------------+
ETDict* ETDict::HasKey(string akey, ETDictType atype = ET_UNDEF)
  {
   ETDict *e = FindKey(akey);
   if(CheckPointer(e) != POINTER_INVALID)
     {
      if(atype == ET_UNDEF || atype == e.m_type)
         return GetPointer(e);
     }
   return NULL;
  }

//+------------------------------------------------------------------+
//|  Operator =                                                      |
//+------------------------------------------------------------------+
void ETDict::operator=(const ETDict &a)
  {
   Copy(a);
  }

//+------------------------------------------------------------------+
//|  Operator =                                                      |
//+------------------------------------------------------------------+
void ETDict::operator=(const int a)
  {
   m_type = ET_INT;
   m_iv = a;
   m_lv = (long)m_iv;
   m_dtv = (datetime)m_iv;
   m_dv = (double) m_iv;
   m_fv = (float) m_iv;
   m_bv = m_iv != 0;
   m_sv = IntegerToString(m_lv);
  }

//+------------------------------------------------------------------+
//|  Operator =                                                      |
//+------------------------------------------------------------------+
void ETDict::operator=(const long a)
  {
   m_type = ET_LONG;
   m_lv = a;
   m_iv = (int)m_lv;
   m_dtv = (datetime)m_iv;
   m_dv = (double) m_iv;
   m_fv = (float) m_iv;
   m_bv = m_iv != 0;
   m_sv = IntegerToString(m_lv);
  }

//+------------------------------------------------------------------+
//|  Operator =                                                      |
//+------------------------------------------------------------------+
void ETDict::operator=(const double a)
  {
   m_type = ET_DOUBLE;
   m_dv = a;
   m_fv = (float)m_dv;
   m_iv = (int) m_dv;
   m_lv = (long)m_iv;
   m_dtv = (datetime)m_iv;
   m_bv = m_iv != 0;
   m_sv = IntegerToString(m_lv);
  }

//+------------------------------------------------------------------+
//|  Operator =                                                      |
//+------------------------------------------------------------------+
void ETDict::operator=(const bool a)
  {
   m_type = ET_BOOL;
   m_bv = a;
   m_iv = (int) m_bv;
   m_lv = (long)m_iv;
   m_dtv = (datetime)m_iv;
   m_dv = (double) m_bv;
   m_fv = (float)m_dv;
   m_sv = IntegerToString(m_lv);
  }

//+------------------------------------------------------------------+
//|  Operator =                                                      |
//+------------------------------------------------------------------+
void ETDict::operator=(string a)
  {
   m_type = (a != NULL) ? ET_STRING : ET_NULL;
   m_sv = a;
   m_lv = StringToInteger(m_sv);
   m_iv = (int)m_lv;
   m_dv = StringToDouble(m_sv);
   m_fv = (float)m_dv;
   m_dtv = StringToTime(a);
   m_bv = a != NULL;
  }

//+------------------------------------------------------------------+
//|  Operator ==                                                     |
//+------------------------------------------------------------------+
bool ETDict::operator==(const int a)
  {
   return m_iv == a;
  }

//+------------------------------------------------------------------+
//|  Operator ==                                                     |
//+------------------------------------------------------------------+
bool ETDict::operator==(const long a)
  {
   return m_iv == a;
  }

//+------------------------------------------------------------------+
//|  Operator ==                                                     |
//+------------------------------------------------------------------+
bool ETDict::operator==(const datetime a)
  {
   return m_dtv == a;
  }
  
//+------------------------------------------------------------------+
//|  Operator ==                                                     |
//+------------------------------------------------------------------+
bool ETDict::operator==(const double a)
  {
   return m_dv == a;
  }

//+------------------------------------------------------------------+
//|  Operator ==                                                     |
//+------------------------------------------------------------------+
bool ETDict::operator==(const float a)
  {
   return m_fv == a;
  }
  
//+------------------------------------------------------------------+
//|  Operator ==                                                     |
//+------------------------------------------------------------------+
bool ETDict::operator==(const bool a)
  {
   return m_bv == a;
  }

//+------------------------------------------------------------------+
//|  Operator ==                                                     |
//+------------------------------------------------------------------+
bool ETDict::operator==(string a)
  {
   return m_sv == a;
  }

//+------------------------------------------------------------------+
//|  Operator !=                                                     |
//+------------------------------------------------------------------+
bool ETDict::operator!=(const int a)
  {
   return m_iv != a;
  }

//+------------------------------------------------------------------+
//|  Operator !=                                                     |
//+------------------------------------------------------------------+
bool ETDict::operator!=(const long a)
  {
   return m_lv != a;
  }
  
//+------------------------------------------------------------------+
//|  Operator !=                                                     |
//+------------------------------------------------------------------+
bool ETDict::operator!=(const datetime a)
  {
   return m_dtv != a;
  }
  
//+------------------------------------------------------------------+
//| Operator !=                                                      |
//+------------------------------------------------------------------+
bool ETDict::operator!=(const double a)
  {
   return m_dv != a;
  }

//+------------------------------------------------------------------+
//| Operator !=                                                      |
//+------------------------------------------------------------------+
bool ETDict::operator!=(const float a)
  {
   return m_fv != a;
  }
  
//+------------------------------------------------------------------+
//| Operator !=                                                      |
//+------------------------------------------------------------------+
bool ETDict::operator!=(const bool a)
  {
   return m_bv != a;
  }

//+------------------------------------------------------------------+
//| Operator !=                                                      |
//+------------------------------------------------------------------+
bool ETDict::operator!=(string a)
  {
   return m_sv != a;
  }

//+------------------------------------------------------------------+
//| To Integer                                                       |
//+------------------------------------------------------------------+
int ETDict::ToInt() const
  {
   return (int)m_iv;
  }
//+------------------------------------------------------------------+
//| To Long                                                          |
//+------------------------------------------------------------------+
long ETDict::ToLong() const
  {
   return m_iv;
  }
  
//+------------------------------------------------------------------+
//| To Datetime                                                      |
//+------------------------------------------------------------------+
datetime ETDict::ToDatetime() const
  {
   return m_dtv;
  }
    
//+------------------------------------------------------------------+
//| To Double                                                        |
//+------------------------------------------------------------------+
double ETDict::ToDouble() const
  {
   return m_dv;
  }

//+------------------------------------------------------------------+
//| To Float                                                         |
//+------------------------------------------------------------------+
double ETDict::ToFloat() const
  {
   return m_fv;
  }
  
//+------------------------------------------------------------------+
//| To Bool                                                          |
//+------------------------------------------------------------------+
bool ETDict::ToBool() const
  {
   return m_bv;
  }
//+------------------------------------------------------------------+
//| To String                                                        |
//+------------------------------------------------------------------+
string ETDict::ToStr()
  {
   return m_sv;
  }

//+------------------------------------------------------------------+
//| From String                                                      |
//+------------------------------------------------------------------+
void ETDict::FromStr(ETDictType t, string a)
  {
   m_type = t;
   switch(m_type)
     {
      case ET_BOOL:
         m_bv = (StringToInteger(a) != 0);
         m_iv = (int) m_bv;
         m_lv = (long) m_iv;
         m_dtv = (datetime) m_iv;
         m_dv = (double) m_iv;
         m_fv = (float) m_iv;
         m_sv = a;
         break;
      case ET_INT:
         m_lv = StringToInteger(a);
         m_iv = (int)m_lv;
         m_dtv = (datetime) m_iv;
         m_dv = (double) m_iv;
         m_fv = (float) m_iv;
         m_sv = a;
         m_bv = m_iv != 0;
         break;
      case ET_LONG:
         m_lv = StringToInteger(a);
         m_iv = (int) m_iv;
         m_dtv = (datetime) m_iv;
         m_dv = (double) m_iv;
         m_fv = (float) m_iv;
         m_sv = a;
         m_bv = m_iv != 0;
         break;         
      case ET_DOUBLE:
         m_dv = StringToDouble(a);
         m_fv = (float)m_dv;
         m_iv = (int) m_dv;
         m_lv = (long) m_dv;
         m_dtv = (datetime) m_iv;
         m_sv = a;
         m_bv = m_iv != 0;
         break;
      case ET_STRING:
         m_sv = Unescape(a);
         m_type = (m_sv != NULL) ? ET_STRING : ET_NULL;
         m_lv = StringToInteger(m_sv);
         m_iv = (int)m_lv;
         m_dtv = StringToTime(m_sv);
         m_dv = StringToDouble(m_sv);
         m_fv = (float)m_dv;
         m_bv = m_sv != NULL;
         break;
     }
  }

//+------------------------------------------------------------------+
//| Get String                                                       |
//+------------------------------------------------------------------+
string ETDict::GetStr(char &js[], int i, int slen)
  {
   if(slen == 0)
      return "";
   char cc[];
   ArrayCopy(cc, js, 0, i, slen);
   return CharArrayToString(cc, 0, WHOLE_ARRAY, ETDict::code_page);
  }

//+------------------------------------------------------------------+
//| Set ETDict                                                       |
//+------------------------------------------------------------------+
void ETDict::Set(const ETDict &a)
  {
   if(m_type == ET_UNDEF)
      m_type = ET_OBJ;
   CopyData(a);
  }


//+------------------------------------------------------------------+
//| Add ETDict                                                       |
//+------------------------------------------------------------------+
ETDict* ETDict::Add(const ETDict &item)
  {
   if(m_type == ET_UNDEF)
      m_type = ET_ARRAY;
   return AddBase(item);
  }

//+------------------------------------------------------------------+
//| Add int                                                          |
//+------------------------------------------------------------------+
ETDict* ETDict::Add(const int a)
  {
   ETDict item(a);
   return Add(item);
  }

//+------------------------------------------------------------------+
//| Add long                                                         |
//+------------------------------------------------------------------+
ETDict* ETDict::Add(const long a)
  {
   ETDict item(a);
   return Add(item);
  }

//+------------------------------------------------------------------+
//| Add double                                                       |
//+------------------------------------------------------------------+
ETDict* ETDict::Add(const double a, int aprec = -2)
  {
   ETDict item(a, aprec);
   return Add(item);
  }

//+------------------------------------------------------------------+
//| Add bool                                                         |
//+------------------------------------------------------------------+
ETDict* ETDict::Add(const bool a)
  {
   ETDict item(a);
   return Add(item);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ETDict* ETDict::Add(string a)
  {
   ETDict item(ET_STRING, a);
   return Add(item);
  }

//+------------------------------------------------------------------+
//|  Add Base                                                        |
//+------------------------------------------------------------------+
ETDict* ETDict::AddBase(const ETDict &item)
  {
   int c = Size();
   ArrayResize(m_e, c + 1, 100);
   m_e[c] = item;
   m_e[c].m_parent = GetPointer(this);
   return GetPointer(m_e[c]);
  }

//+------------------------------------------------------------------+
//| New                                                              |
//+------------------------------------------------------------------+
ETDict* ETDict::New()
  {
   if(m_type == ET_UNDEF)
      m_type = ET_ARRAY;
   return NewBase();
  }

//+------------------------------------------------------------------+
//| NewBase                                                          |
//+------------------------------------------------------------------+
ETDict* ETDict::NewBase()
  {
   int c = Size();
   ArrayResize(m_e, c + 1, 100);
   return GetPointer(m_e[c]);
  }

//+------------------------------------------------------------------+
//| Serialize                                                        |
//+------------------------------------------------------------------+
string ETDict::Serialize()
  {
   string js;
   Serialize(js);
   return js;
  }

//+------------------------------------------------------------------+
//| Deserialize                                                      |
//+------------------------------------------------------------------+
bool ETDict::Deserialize(string js, int acp = CP_ACP)
  {
   js = Unescape(js);
   int i = 0;
   Clear();
   ETDict::code_page = acp;
   char arr[];
   int slen = StringToCharArray(js, arr, 0, WHOLE_ARRAY, ETDict::code_page);
   return Deserialize(arr, slen, i);
  }

//+------------------------------------------------------------------+
//| Deserialize                                                      |
//+------------------------------------------------------------------+
bool ETDict::Deserialize(char &js[], int acp = CP_ACP)
  {
   int i = 0;
   Clear();
   ETDict::code_page = acp;
   return Deserialize(js, ArraySize(js), i);
  }

//+------------------------------------------------------------------+
//| Operator []                                                      |
//+------------------------------------------------------------------+
ETDict* ETDict::operator[](string akey)
  {
   if(m_type == ET_UNDEF)
      m_type = ET_OBJ;
   ETDict *v = FindKey(akey);
   if(v)
      return v;
   ETDict b(GetPointer(this), ET_UNDEF);
   b.m_key = akey;
   v = Add(b);
   return v;
  }

//+------------------------------------------------------------------+
//|  Operator []                                                     |
//+------------------------------------------------------------------+
ETDict* ETDict::operator[](int i)
  {
   if(m_type == ET_UNDEF)
      m_type = ET_ARRAY;
   while(i >= Size())
     {
      ETDict b(GetPointer(this), ET_UNDEF);
      if(CheckPointer(Add(b)) == POINTER_INVALID)
         return NULL;
     }
   return GetPointer(m_e[i]);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ETDict::Set(const ETDict &list[])
  {
   if(m_type == ET_UNDEF)
      m_type = ET_ARRAY;
   int n = ArrayResize(m_e, ArraySize(list), 100);
   for(int i = 0; i < n; ++i)
     {
      m_e[i] = list[i];
      m_e[i].m_parent = GetPointer(this);
     }
  }

//+------------------------------------------------------------------+
//| Serialize a string                                               |
//+------------------------------------------------------------------+
void ETDict::Serialize(string &js, bool bkey, bool coma)
  {
   if(m_type == ET_UNDEF)
      return;
   if(coma)
      js += ",";
   if(bkey)
      js += StringFormat("\"%s\":", m_key);
   int _n = Size();
   switch(m_type)
     {
      case ET_NULL:
         js += "null";
         break;
      case ET_BOOL:
         js += (m_bv ? "true" : "false");
         break;
      case ET_INT:
         js += IntegerToString(m_iv);
         break;
      case ET_DOUBLE:
         js += DoubleToString(m_dv, m_prec);
         break;
      case ET_STRING:
        {
         string ss = Escape(m_sv);
         if(StringLen(ss) > 0)
            js += StringFormat("\"%s\"", ss);
         else
            js += "null";
        }
      break;
      case ET_ARRAY:
         js += "[";
         for(int i = 0; i < _n; i++)
            m_e[i].Serialize(js, false, i > 0);
         js += "]";
         break;
      case ET_OBJ:
         js += "{";
         for(int i = 0; i < _n; i++)
            m_e[i].Serialize(js, true, i > 0);
         js += "}";
         break;
     }
  }

//+------------------------------------------------------------------+
//| Deserialize                                                      |
//+------------------------------------------------------------------+
bool ETDict::Deserialize(char &js[], int slen, int &i)
  {
   string num = "0123456789+-.eE";
   int i0 = i;
   for(; i < slen; i++)
     {
      char c = js[i];
      if(c == 0)
         break;
      switch(c)
        {
         case '\t':
         case '\r':
         case '\n':
         case ' ':
            i0 = i + 1;
            break;

         case '[':
           {
            i0 = i + 1;
            if(m_type != ET_UNDEF)
              {
               Print(m_key + " " + string(__LINE__));
               return false;
              }
            m_type = ET_ARRAY;
            i++;
            ETDict val(GetPointer(this), ET_UNDEF);
            while(val.Deserialize(js, slen, i))
              {
               if(val.m_type != ET_UNDEF)
                  Add(val);
               if(val.m_type == ET_INT || val.m_type == ET_DOUBLE
                  || val.m_type == ET_ARRAY)
                  i++;
               val.Clear();
               val.m_parent = GetPointer(this);
               if(js[i] == ']')
                  break;
               i++;
               if(i >= slen)
                 {
                  Print(m_key + " " + string(__LINE__));
                  return false;
                 }
              }
            return js[i] == ']' || js[i] == 0;
           }
         break;
         case ']':
            if(!m_parent)
               return false;
            return m_parent.m_type == ET_ARRAY;

         case ':':
           {
            if(m_lkey == "")
              {
               Print(m_key + " " + string(__LINE__));
               return false;
              }
            ETDict val(GetPointer(this), ET_UNDEF);
            ETDict *oc = Add(val);
            oc.m_key = m_lkey;
            m_lkey = "";
            i++;
            if(!oc.Deserialize(js, slen, i))
              {
               Print(m_key + " " + string(__LINE__));
               return false;
              }
            break;
           }
         case ',':
            i0 = i + 1;
            if(!m_parent && m_type != ET_OBJ)
              {
               Print(m_key + " " + string(__LINE__));
               return false;
              }
            else
               if(m_parent)
                 {
                  if(m_parent.m_type != ET_ARRAY && m_parent.m_type != ET_OBJ)
                    {
                     Print(m_key + " " + string(__LINE__));
                     return false;
                    }
                  if(m_parent.m_type == ET_ARRAY && m_type == ET_UNDEF)
                     return true;
                 }
            break;

         case '{':
            i0 = i + 1;
            if(m_type != ET_UNDEF)
              {
               Print(m_key + " " + string(__LINE__));
               return false;
              }
            m_type = ET_OBJ;
            i++;
            if(!Deserialize(js, slen, i))
              {
               Print(m_key + " " + string(__LINE__));
               return false;
              }
            if (ArraySize(js) < i + 1) ArrayResize(js, i+1);
            return js[i] == '}' || js[i] == 0;
            break;
         case '}':
            return m_type == ET_OBJ;

         case 't':
         case 'T':
         case 'f':
         case 'F':
            if(m_type != ET_UNDEF)
              {
               Print(m_key + " " + string(__LINE__));
               return false;
              }
            m_type = ET_BOOL;
            if(i + 3 < slen)
              {
               if(StringCompare(GetStr(js, i, 4), "true", false) == 0)
                 {
                  m_bv = true;
                  i += 3;
                  return true;
                 }
              }
            if(i + 4 < slen)
              {
               if(StringCompare(GetStr(js, i, 5), "false", false) == 0)
                 {
                  m_bv = false;
                  i += 4;
                  return true;
                 }
              }
            Print(m_key + " " + string(__LINE__));
            return false;
            break;
         case 'n':
         case 'N':
            if(m_type != ET_UNDEF)
              {
               Print(m_key + " " + string(__LINE__));
               return false;
              }
            m_type = ET_NULL;
            if(i + 3 < slen)
               if(StringCompare(GetStr(js, i, 4), "null", false) == 0)
                 {
                  i += 3;
                  return true;
                 }
            Print(m_key + " " + string(__LINE__));
            return false;
            break;

         case '0':
         case '1':
         case '2':
         case '3':
         case '4':
         case '5':
         case '6':
         case '7':
         case '8':
         case '9':
         case '-':
         case '+':
         case '.':
           {
            if(m_type != ET_UNDEF)
              {
               Print(m_key + " " + string(__LINE__));
               return false;
              }
            bool dbl = false;
            int is = i;
            while(js[i] != 0 && i < slen)
              {
               i++;
               if(StringFind(num, GetStr(js, i, 1)) < 0)
                  break;
               if(!dbl)
                  dbl = (js[i] == '.' || js[i] == 'e' || js[i] == 'E');
              }
            m_sv = GetStr(js, is, i - is);
            if(dbl)
              {
               m_type = ET_DOUBLE;
               m_dv = StringToDouble(m_sv);
               m_fv = (float)m_dv;
               m_iv = (int) m_dv;
               m_lv = (long)m_iv;
               m_dtv = StringToTime(m_sv);
               m_bv = m_iv != 0;
              }
            else
              {
               m_type = ET_INT;
               m_lv = StringToInteger(m_sv);
               m_iv = (int)m_lv;
               m_dtv = StringToTime(m_sv);
               m_dv = (double) m_iv;
               m_fv = (float)m_iv;
               m_bv = m_iv != 0;
              }
            break;
           }
         case '\"':
            if(m_type == ET_OBJ)
              {
               i++;
               int is = i;
               if(!ExtrStr(js, slen, i))
                 {
                  Print(m_key + " " + string(__LINE__));
                  return false;
                 }
               m_lkey = GetStr(js, is, i - is);
              }
            else
              {
               if(m_type != ET_UNDEF)
                 {
                  Print(m_key + " " + string(__LINE__));
                  return false;
                 }
               m_type = ET_STRING;
               i++;
               int is = i;
               if(!ExtrStr(js, slen, i))
                 {
                  Print(m_key + " " + string(__LINE__));
                  return false;
                 }
               FromStr(ET_STRING, GetStr(js, is, i - is));
               return true;
              }
            break;
        }
     }
   return true;
  }

//+------------------------------------------------------------------+
//| Extract string                                                   |
//+------------------------------------------------------------------+
bool ETDict::ExtrStr(char &js[], int slen, int &i)
  {
   for(; js[i] != 0 && i < slen; i++)
     {
      char c = js[i];
      if(c == '\"')
         break;
      if(c == '\\' && i + 1 < slen)
        {
         i++;
         c = js[i];
         switch(c)
           {
            case '/':
            case '\\':
            case '\"':
            case 'b':
            case 'f':
            case 'r':
            case 'n':
            case 't':
               break;
            case 'u': // \uXXXX
              {
               i++;
               for(int j = 0; j < 4 && i < slen && js[i] != 0; j++, i++)
                 {
                  if(!((js[i] >= '0' && js[i] <= '9')
                       || (js[i] >= 'A' && js[i] <= 'F')
                       || (js[i] >= 'a' && js[i] <= 'f')))
                    {
                     Print(
                        m_key + " " + CharToString(js[i]) + " "
                        + string(__LINE__));   // не hex
                     return false;
                    }
                 }
               i--;
               break;
              }
            default:
               break;
           }
        }
     }
   return true;
  }

//+------------------------------------------------------------------+
//|  Escape String                                                   |
//+------------------------------------------------------------------+
string ETDict::Escape(string a)
  {
   ushort as[], s[];
   int n = StringToShortArray(a, as);
   if(ArrayResize(s, 2 * n) != 2 * n)
      return NULL;
   int j = 0;
   for(int i = 0; i < n; i++)
     {
      switch(as[i])
        {
         case '\\':
            s[j] = '\\';
            j++;
            s[j] = '\\';
            j++;
            break;
         case '"':
            s[j] = '\\';
            j++;
            s[j] = '"';
            j++;
            break;
         case '/':
            s[j] = '\\';
            j++;
            s[j] = '/';
            j++;
            break;
         case 8:
            s[j] = '\\';
            j++;
            s[j] = 'b';
            j++;
            break;
         case 12:
            s[j] = '\\';
            j++;
            s[j] = 'f';
            j++;
            break;
         case '\n':
            s[j] = '\\';
            j++;
            s[j] = 'n';
            j++;
            break;
         case '\r':
            s[j] = '\\';
            j++;
            s[j] = 'r';
            j++;
            break;
         case '\t':
            s[j] = '\\';
            j++;
            s[j] = 't';
            j++;
            break;
         default:
            s[j] = as[i];
            j++;
            break;
        }
     }
   a = ShortArrayToString(s, 0, j);
   return a;
  }

//+------------------------------------------------------------------+
//| Unescape String                                                  |
//+------------------------------------------------------------------+
string ETDict::Unescape(string a)
  {
   ushort as[], s[];
   int n = StringToShortArray(a, as);
   if(ArrayResize(s, n) != n)
      return NULL;
   int j = 0, i = 0;
   while(i < n)
     {
      ushort c = as[i];
      if(c == '\\' && i < n - 1)
        {
         switch(as[i + 1])
           {
            case '\\':
               c = '\\';
               i++;
               break;
            case '"':
               c = '"';
               i++;
               break;
            case '/':
               c = '/';
               i++;
               break;
            case 'b':
               c = 8; /*08='\b'*/
               ;
               i++;
               break;
            case 'f':
               c = 12;/*0c=\f*/
               i++;
               break;
            case 'n':
               c = '\n';
               i++;
               break;
            case 'r':
               c = '\r';
               i++;
               break;
            case 't':
               c = '\t';
               i++;
               break;
            case 'u': // \uXXXX
              {
               i += 2;
               ushort k = 0;
               for(int jj = 0; jj < 4 && i < n; jj++, i++)
                 {
                  c = as[i];
                  ushort h = 0;
                  if(c >= '0' && c <= '9')
                     h = c - '0';
                  else
                     if(c >= 'A' && c <= 'F')
                        h = c - 'A' + 10;
                     else
                        if(c >= 'a' && c <= 'f')
                           h = c - 'a' + 10;
                        else
                           break;
                  k += h * (ushort) pow(16, (3 - jj));
                 }
               i--;
               c = k;
               break;
              }
           }
        }
      s[j] = c;
      j++;
      i++;
     }
   a = ShortArrayToString(s, 0, j);
   return a;
  }
//+------------------------------------------------------------------+
