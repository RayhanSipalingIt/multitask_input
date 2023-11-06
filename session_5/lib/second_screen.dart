import 'package:flutter/material.dart';

class NumberCard {
  int number;

  NumberCard(this.number);
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<NumberCard> _numberCards = [NumberCard(0)];

  void _addCard() {
    final newIndex = _numberCards.length;
    _numberCards.add(NumberCard(0));
    _listKey.currentState!.insertItem(newIndex);
  }

  void _deleteCard(int index) {
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => _buildItem(_numberCards[index], animation, index),
      duration: const Duration(milliseconds: 250),
    );
    setState(() {
      _numberCards.removeAt(index);
    });
  }

  Widget _buildItem(NumberCard numberCard, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: Column(
          children: <Widget>[
            Text(
              'Angka: ${numberCard.number}',
              style: TextStyle(fontSize: 24),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      numberCard.number++;
                    });
                  },
                  child: Text('Increment'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (numberCard.number > 0) {
                      setState(() {
                        numberCard.number--;
                      });
                    }
                  },
                  child: Text('Decrement'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _deleteCard(index);
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String data = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nama anda: $data',
              style: TextStyle(fontSize: 24),
            ),
            Expanded(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: _numberCards.length,
                itemBuilder: (context, index, animation) {
                  return _buildItem(_numberCards[index], animation, index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(
              context,
              '/first',
            );
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'First',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Second',
          ),
        ],
      ),
    );
  }
}

void main() => runApp(
      MaterialApp(
        title: 'Navigation Codelab',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/second',
        routes: {
          '/second': (context) => SecondScreen(),
        },
      ),
    );
