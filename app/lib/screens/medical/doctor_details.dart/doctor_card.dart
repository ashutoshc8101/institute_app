import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String contact;
  final String specialization;
  final String details;
  final String email;
  final String startTime;
  final String endTime;

  const DoctorCard({
    Key? key,
    required this.name,
    required this.details,
    required this.specialization,
    required this.contact,
    required this.email,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(81, 158, 158, 158),
                offset: Offset(0, 3),
                blurRadius: 3.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.00, 25.00, 30.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Image.asset("assets/icons/staff_contact_profile.png"),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            specialization,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            contact,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            email,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ]),
                    Text(
                      details,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 12.5, 10.0, 12.5),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Take Appointment",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 12.5, 10.0, 12.5),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          startTime + " - " + endTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
