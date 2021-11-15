import 'package:app/app.dart';
import 'package:app/commons/colors.dart';
import 'package:app/vehicle/add/bloc/add_vehicle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeEmailOrPhone extends StatelessWidget {
  const ChangeEmailOrPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddVehicleBloc, AddVehicleState>(
      listener: (context, state) {
        // if (state.status.isSubmissionFailure) {
        //   ScaffoldMessenger.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       const SnackBar(content: Text('Submission Failure')),
        //     );
        // } else if (state.status.isSubmissionSuccess) {
        //   ScaffoldMessenger.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       const SnackBar(content: Text('Your Submission has been Saved')),
        //     );
        //   Navigator.pop(context, state);
        // }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Change email or phone number",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            "Email/Phone number*",
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter email or phone number*",
            ),
          ),
          SizedBox(
            height: 10.0,
          ),

          SizedBox(
            height: kDeviceSize.height * 0.2,
          ),
          Text(
            'Submit your email or phone number to recieve a verification code for your device.',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.normal, fontSize:13.0, color: kAppPrimaryColor),
                textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDeviceSize.width * 0.1),
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Submit'),
                  SizedBox(
                    width: kDeviceSize.width * 0.05,
                  ),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}


// class _SubmitButton extends StatelessWidget {
//   const _SubmitButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddVehicleBloc, AddVehicleState>(
//       builder: (context, state) {
//         return state.status.isSubmissionInProgress
//             ? Center(
//                 child: const CircularProgressIndicator(),
//               )
//             : Padding(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: kDeviceSize.width * 0.1),
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     elevation: MaterialStateProperty.all(0),
//                   ),
//                   onPressed: state.status.isValidated
//                       ? () {
//                           //context.read<AddUserBloc>().add(FormSubmitted());
//                         }
//                       : null,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('submit').tr(),
//                     ],
//                   ),
//                 ),
//               );
//       },
//     );
//   }
// }
