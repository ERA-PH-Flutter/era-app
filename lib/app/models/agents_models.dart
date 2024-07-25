class AgentsModels {
  final String image;
  final String firstName;
  final String lastName;
  final String whatsappIcon;
  final String whatsapp;
  final String emailIcon;

  final String email;
  final String type;
  AgentsModels({
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.type,
    required this.whatsappIcon,
    required this.whatsapp,
    required this.emailIcon,
    required this.email,
  });

  static List<AgentsModels> agentsModels = [
    AgentsModels(
        image: "assets/images/agentpfp.png",
        firstName: "John",
        lastName: "Doe",
        type: "AGENT/BROKER",
        whatsappIcon: "assets/icons/whatsapp.png",
        whatsapp: "1234-123-1234",
        emailIcon: "assets/icons/mail.png",
        email: "name@mail.com"),
    AgentsModels(
        image: "assets/images/agentpfp.png",
        firstName: "Alison",
        lastName: "Smith",
        type: "AGENT/BROKER",
        whatsappIcon: "assets/icons/whatsapp.png",
        whatsapp: "1234-123-1234",
        emailIcon: "assets/icons/mail.png",
        email: "name@mail.com"),
    AgentsModels(
        image: "assets/images/agentpfp.png",
        firstName: "Mark",
        lastName: "Williams",
        type: "AGENT/BROKER",
        whatsappIcon: "assets/icons/whatsapp.png",
        whatsapp: "1234-123-1234",
        emailIcon: "assets/icons/mail.png",
        email: "name@mail.com"),
  ];
}
