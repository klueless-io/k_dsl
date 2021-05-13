namespace {{project.application_namespace}}.Models
{
  using System;

  public class ErrorViewModel
  {
    public string RequestId { get; set; }

    public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);
  }
}
