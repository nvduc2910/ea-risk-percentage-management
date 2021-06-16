//+------------------------------------------------------------------+
//|                                                       CAONGUYENHK|
//|                                                      CAONGUYENHK |
//|                           https://t.me/fxtradingcaonguyenhkgroup |
//+------------------------------------------------------------------+
#property copyright "CAONGUYENHK"
#property link      "https://t.me/fxtradingcaonguyenhkgroup"
#property version   "1.00"

#include <Trade\Trade.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\OrderInfo.mqh>
#include <Arrays\ArrayLong.mqh>

CTrade         m_trade;      // trading object
CPositionInfo  m_position;   // position info object
COrderInfo     m_order;      // order info object
CArrayLong     m_arr_tickets;// array tickets

input double              PERCENT_SL         = 5.0;

double                    m_balance         = 0;

double MaxPostionLoss;
double TotalPositionProfit;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   m_balance = AccountInfoDouble(ACCOUNT_BALANCE);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   TotalPositionProfit = 0;
//---
   if(PositionsTotal() == 0)
     {
      m_balance = AccountInfoDouble(ACCOUNT_BALANCE);
     }

   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      int ticket = PositionGetTicket(i);
      double PositionProfit = PositionGetDouble(POSITION_PROFIT);
      TotalPositionProfit = TotalPositionProfit + PositionProfit;
     }

   Comment(
      "CAONGUYENHK - COPY TRADE\n",
      "Balance: ", m_balance, "\n",
      "Current Trade: ", TotalPositionProfit, "\n",
      "Percentage: ", PERCENT_SL, "%\n"
   );

   if(AccountInfoDouble(ACCOUNT_EQUITY) <= m_balance*(100-PERCENT_SL)/100)
     {
      CloseAllTransaction();
     }
  }
//+------------------------------------------------------------------+
void CloseAllTransaction()
  {
   for(int i = PositionsTotal() - 1; i >=0 ; i--)
     {
      int ticket = PositionGetTicket(i);
      m_trade.PositionClose(ticket);
     }
  }
//+------------------------------------------------------------------+
