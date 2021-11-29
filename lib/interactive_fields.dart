import 'package:flutter/material.dart';

class InteractiveFields extends StatefulWidget {
  const InteractiveFields({Key? key}) : super(key: key);

  @override
  InteractiveFieldsState createState() => InteractiveFieldsState();
}

class InteractiveFieldsState extends State<InteractiveFields> {
  String firstName = "Emma";
  String lastName = "Watson";
  String secretWord = "";
  bool showSecretWord = false;
  dynamic age = 0;
  double size = 150;
  bool genre = false;
  Map<String, bool> hobbies = {
    'Pétanque': false,
    'Football': false,
    'Rugby': false,
    'Code': false,
  };
  int groupValue = 1;
  String favoriteLanguage = "";

  List<String> prefLanguage = ["Dart", "JavaScript", "Python", "Java", "C#"];

  @override
  void initState() {
    super.initState();
    // controller = TextEditingController();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon profil"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.deepPurple[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 3.0),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                  )
                ],
              ),
              child: Center(
                child: Column(
                  children: [
                    Text("$firstName $lastName"),
                    Text("Age: $age ans"),
                    Text("Taille: ${size.toInt()} cm"),
                    Text((genre) ? "Genre: Féminin" : "Genre: Masculin"),
                    hobbiesFormated(),
                    Text((favoriteLanguage != "")
                        ? "Langage de programmation favori: $favoriteLanguage"
                        : ""),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showSecretWord = !showSecretWord;
                          print(showSecretWord);
                        });
                      },
                      child: Text('Montrer secret'),
                    ),
                    Text((showSecretWord) ? "$secretWord" : ""),
                    //showSecretWord ? Text("secret") : null,
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.purple,
            ),
            Text(
              'Modifier les infos',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            infos(),
            Divider(
              thickness: 2,
              color: Colors.purple,
            ),
            hobbiesContainer(),
            Divider(
              thickness: 2,
              color: Colors.purple,
            ),
            radios(prefLanguage),
          ],
        ),
      ),
    );
  }

  Container infos() {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Votre prénom",
            ),
            onSubmitted: ((newFirstName) {
              setState(() {
                firstName = newFirstName;
              });
            }),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Votre nom",
            ),
            onSubmitted: ((newLastName) {
              setState(() {
                lastName = newLastName;
              });
            }),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Mot secret",
            ),
            onSubmitted: ((newSecretWord) {
              setState(() {
                secretWord = newSecretWord;
              });
            }),
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Age',
            ),
            onSubmitted: ((newAge) {
              setState(() {
                age = newAge as String;
              });
            }),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text((genre) ? "Genre: Féminin" : "Genre: Masculin"),
              Switch(
                value: genre,
                onChanged: ((newGenre) {
                  setState(() {
                    genre = newGenre;
                  });
                }),
                activeColor: Colors.purple,
                inactiveTrackColor: Colors.blue,
                inactiveThumbColor: Colors.blue,
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Votre taille: ${size.toInt()} cm'),
              Slider(
                value: size,
                min: 50,
                max: 250,
                onChanged: ((newSize) {
                  setState(() {
                    size = newSize;
                  });
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container hobbiesContainer() {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Center(
            child: Text(
              'Mes hobbies:',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: hobbiesColumn(),
          ),
        ],
      ),
    );
  }

  Column hobbiesColumn() {
    List<Widget> hobbiesList = [];
    hobbies.forEach((hobbie, status) {
      Widget hobbieRow = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hobbie,
          ),
          Checkbox(
            value: status,
            onChanged: ((newStatus) {
              setState(() {
                hobbies[hobbie] = newStatus ?? false;
              });
            }),
          ),
        ],
      );
      hobbiesList.add(hobbieRow);
    });
    return Column(
      children: hobbiesList,
    );
  }

  Text hobbiesFormated() {
    String hobbiesText = "Hobbies: ";
    hobbies.forEach((hobbie, status) {
      status ? hobbiesText += "$hobbie, " : null;
    });
    return Text(hobbiesText);
  }

  Row radios(language) {
    List<Widget> radios = [];
    for (var i = 0; i < language.length; i++) {
      Column r = Column(
        children: [
          Text(language[i]),
          Radio(
            value: i,
            groupValue: groupValue,
            onChanged: ((newValue) {
              setState(() {
                groupValue = newValue as int;
                favoriteLanguage = language[groupValue];
              });
            }),
          ),
        ],
      );
      radios.add(r);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: radios,
    );
  }
}
