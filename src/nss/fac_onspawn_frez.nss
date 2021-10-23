#include "x0_i0_petrify"

void main()
{
  AssignCommand(OBJECT_SELF, ClearAllActions(TRUE));
  AssignCommand(OBJECT_SELF, SetCommandable(FALSE, OBJECT_SELF));

  DelayCommand(1.0, Petrify(OBJECT_SELF));
  DelayCommand(1.3, SetPlotFlag(OBJECT_SELF, TRUE));
}
