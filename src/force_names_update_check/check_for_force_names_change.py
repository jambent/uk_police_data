def check_for_force_names_change(
        stored_force_names_list,
        new_force_names_list):
    force_names_check_results_dict = {}

    change_in_force_names_number = len(
        new_force_names_list) - len(stored_force_names_list)
    if change_in_force_names_number > 0:
        force_names_check_results_dict["number_of_force_names"] = \
            f"Increased by {change_in_force_names_number}"
        forces_added = []
        for force in new_force_names_list:
            if force not in stored_force_names_list:
                forces_added.append(force)
        force_names_check_results_dict["force_names_added"] = forces_added

    elif change_in_force_names_number < 0:
        force_names_check_results_dict["number_of_force_names"] = \
            f"Decreased by {change_in_force_names_number}"
        forces_removed = []
        for force in stored_force_names_list:
            if force not in new_force_names_list:
                forces_removed.append(force)
        force_names_check_results_dict["force_names_removed"] = forces_removed

    else:
        force_names_check_results_dict["number_of_force_names"] = "No change"

    return force_names_check_results_dict
