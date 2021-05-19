import 'package:flutter/material.dart';

class MyActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نشاطي'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          post(
              'Khaled Mohamed',
              '4200\n ريال',
              'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/145442707_2866291720305610_6893681363896788682_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=PmFE_GfUzo8AX_CL4Nx&_nc_ht=scontent-hbe1-1.xx&oh=1a1096bb0420aeb0871ff43c0bef18c2&oe=609808D6',
              'https://el5olasa.com/wp-content/uploads/2019/10/%D9%84%D8%A7%D8%A8%D8%AA%D9%88%D8%A8-XPS-15-%D8%B7%D8%B1%D8%A7%D8%B2-2020-%D8%A3%D9%81%D8%B6%D9%84-%D9%84%D8%A7%D8%A8%D8%AA%D9%88%D8%A8-%D8%AF%D9%8A%D9%84-768x384.png',
              'لاب توب apple جيل خامس \n رام: 8 جيجابايت \n هارد: 1000 جيجا , شاشة 15 بوصه full hd',
              '+201064871625',context ),
          post(
              'Khaled Mohamed',
              'free',
              'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/145442707_2866291720305610_6893681363896788682_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=PmFE_GfUzo8AX_CL4Nx&_nc_ht=scontent-hbe1-1.xx&oh=1a1096bb0420aeb0871ff43c0bef18c2&oe=609808D6',
              'https://el5olasa.com/wp-content/uploads/2019/10/%D9%84%D8%A7%D8%A8%D8%AA%D9%88%D8%A8-XPS-15-%D8%B7%D8%B1%D8%A7%D8%B2-2020-%D8%A3%D9%81%D8%B6%D9%84-%D9%84%D8%A7%D8%A8%D8%AA%D9%88%D8%A8-%D8%AF%D9%8A%D9%84-768x384.png',
              'لاب توب apple جيل خامس \n رام: 8 جيجابايت \n هارد: 1000 جيجا , شاشة 15 بوصه full hd',
              '+201064871625',context ),
        ],
      ),
    );
  }

  Widget post(name , price,photo,product,desc,phone,context){
    return  Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(spreadRadius: .5, blurRadius: 10)],
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage:NetworkImage('$photo'),
                maxRadius: 25,
              ),
              Text(
                '$name',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
             Icon(Icons.delete)
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.pink[900],
                  child: Text(
                    '$price',
                    style: TextStyle(
                        fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,textAlign: TextAlign.center,
                  )),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                child: Image.network(
                    '$product'),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topRight,
            child: Text(
              '$desc',
              style:
              TextStyle(fontSize: 15, color: Colors.grey[800]),
              textDirection: TextDirection.rtl,
            ),
          ),
          Divider(
            thickness: 3,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .1,
                  height: MediaQuery.of(context).size.height * .04,
                  child: Image.asset('images/whats.png'),
                ),
                Text(
                  '$phone',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Icon(Icons.copy)
              ]),
        ],
      ),
    );
  }
}
