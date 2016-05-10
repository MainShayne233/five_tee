var ResetTasksModal = React.createClass({

  componentDidMount(){
    $('.reset.modal').modal('toggle');
    toggleResetModal = this.props.toggleResetModal;
    $('.reset.modal').on('hidden.bs.modal', function (e) {
      toggleResetModal();
    });
  },

  close(){
    $('.reset.modal').modal('toggle');
  },

  render(){
    return(
      <div className="reset modal fade" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-body">
              <a className="full btn btn-lg btn-default">Archive & Reset Tasks</a>
              <a className="full btn btn-lg btn-danger">Reset Tasks Only</a>
              <a onClick={this.close} className="full btn btn-lg btn-default">Close</a>
            </div>
          </div>
        </div>
      </div>
    );
  }

});