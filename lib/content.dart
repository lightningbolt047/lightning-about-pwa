




final List<String> moreAboutMeHeading=["More About Me","What I'm currently working on"];






final List<String> moreAboutMeBody=[
  "I joined the App Development world (and Web Development) in 2020 (during the COVID-19 holidays). One of my friends suggested me to learn Flutter. I was reluctant at first, but began an online course soon after. The first few videos were not that interesting, but as I progressed further, I gradually fell in love with the UI components and the writing style. The cherry on top is that, since the framework supports hot reload ⚡, one can easily see their changes reflect immediately (instead of waiting to compile for each and every change💤). One can either use widgets from the built-in library or hand-craft their own UI from scratch. This freedom is what I love the most about Flutter. I ended up finishing the course and used the framework for my 5th semester’s DBMS project (Flutter web was in beta). Yes, I ended up doing a lot of work by choosing dart instead of going for HTML, CSS: something that everyone knows, but I learnt a whole lot of widgets, dart packages and how to use them.\nSoon after, I started building beautiful UI which could be used across platforms. Now what I needed was knowledge on backend frameworks.\nFrontend without backend wouldn’t make much sense (in most Web Apps), so I’ve learnt PHP and NodeJS for backend and SQL and MongoDB for database.\n\n\nWhat I use\n\n  Jetbrains Suite  (Android Studio, IDEA) for Flutter, Java\n\n  Visual Studio Code (for JS and other web dev stuff)\n\n\nI use Windows as my main OS (drivers are better here; at least for my laptop) and WSL for my linux needs\n\n",
  "I'm currently exploring new project and UI ideas. I'm also learning React and making myself comfortable with it\n\n\nThe tech stack that I'm currently most comfortable with is:\n\n   Flutter for Front-End\n   NodeJS for Back-End\n   MongoDB for Database"
];





final String frontPageContent="Hey, I'm Sashank! I'm a B.Tech undergraduate student at Amrita School of Engineering. I've just stepped into the world of Web/App development (the line keeps blurring). I am a very good problem solver, so I come up with innovative ideas which can make whatever I do better. I'm currently in ♥ with Flutter and exploring different concepts and widgets with it. Ping me on one of my social media handles if you want to collab with me";


final Function getLanguageLogo=(String language){
  if(language=="Dart"){
    return "assets/flutter_icon_blue.png";
  }
  else if(language=="JavaScript"){
    return "assets/javascript_icon_green.png";
  }
  else if(language=="C++"){
    return "assets/cpp_icon_blue.png";
  }
  else if(language=="Java"){
    return "assets/java_icon.png";
  }
  else if(language=="HTML"){
    return "assets/html5_icon.orange.png";
  }
  else if(language=="Python"){
    return "assets/python_icon.png";
  }
  else{
    return "assets/code_icon_blue.png";
  }
};