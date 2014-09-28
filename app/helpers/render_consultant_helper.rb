module RenderConsultantHelper

  FLAG_OVERDUE=1001
  FLAG_ACCESSDENIED=1002
  FLAG_SUCCESS=1
  FLAG_FAILURE=0


  def render_success_json(tips,content={})
    render_json(FLAG_SUCCESS,tips,content)
  end

  def render_failure_json(tips,content={})
    render_json(FLAG_FAILURE,tips,content)
  end

  def render_access_denied_json(tips,content={})
    render_json(FLAG_ACCESSDENIED,tips,content)
  end

  def render_overdue_json(tips,content={})
    render_json(FLAG_OVERDUE,tips,content)
  end

  def render_json(flag,tips,content={})
    json = {
        flag:flag,
        tips:tips,
        content:content,
        time:Time.now.strftime("%Y-%m-%d %H:%M:%S")
    }
    render :json=>json.to_json
  end

end
