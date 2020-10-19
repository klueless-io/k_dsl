#include "{{snake settings.application}}.h"

VALUE rb_m{{camelU settings.application}};

void
Init_{{snake settings.application}}(void)
{
  rb_m{{camelU settings.application}} = rb_define_module("{{camelU settings.application}}");
}
