import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../bloc/booking_cubit.dart';
import '../bloc/booking_state.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null && context.mounted) {
      context.read<BookingCubit>().selectDate(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        if (state.isSuccess) {
          return Scaffold(
            appBar: AppBar(title: const Text('Navbat')),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 80,
                      color: AppColors.adherenceGreen,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Navbat muvaffaqiyatli bron qilindi!',
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () => context.read<BookingCubit>().reset(),
                      child: const Text('Yana bron qilish'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final cubit = context.read<BookingCubit>();

        return Scaffold(
          appBar: AppBar(title: const Text('Navbat bron qilish')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shifokor tanlash',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...cubit.availableDoctors.map(
                  (doctor) => Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: state.selectedDoctor == doctor.name
                            ? colorScheme.primaryContainer
                            : colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.person,
                          color: state.selectedDoctor == doctor.name
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                      title: Text(
                        doctor.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(doctor.specialty),
                      trailing: state.selectedDoctor == doctor.name
                          ? Icon(Icons.check_circle,
                              color: colorScheme.primary)
                          : null,
                      selected: state.selectedDoctor == doctor.name,
                      onTap: () =>
                          context.read<BookingCubit>().selectDoctor(doctor.name),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Sana tanlash',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _pickDate(context),
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      state.selectedDate != null
                          ? '${state.selectedDate!.day.toString().padLeft(2, '0')}.${state.selectedDate!.month.toString().padLeft(2, '0')}.${state.selectedDate!.year}'
                          : 'Sanani tanlang',
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Vaqt tanlash',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    '09:00',
                    '10:00',
                    '11:00',
                    '14:00',
                    '15:00',
                    '16:00',
                  ].map((time) {
                    final selected = state.selectedTime == time;
                    return ChoiceChip(
                      label: Text(time),
                      selected: selected,
                      onSelected: (_) =>
                          context.read<BookingCubit>().selectTime(time),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _reasonController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Murojaat sababi',
                    hintText: 'Qisqacha shikoyatingizni yozing...',
                  ),
                  onChanged: (v) =>
                      context.read<BookingCubit>().updateReason(v),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: state.selectedDoctor != null &&
                            state.selectedDate != null &&
                            state.selectedTime != null &&
                            !state.isSubmitting
                        ? () => context.read<BookingCubit>().submit()
                        : null,
                    icon: state.isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.check),
                    label: Text(
                      state.isSubmitting
                          ? 'Yuborilmoqda...'
                          : 'Bron qilish',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
